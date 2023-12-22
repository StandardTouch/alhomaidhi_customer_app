import 'dart:isolate';
import 'dart:ui';
import 'package:background_downloader/background_downloader.dart'
    as BackgroundDownloader;

import 'package:background_downloader/src/permissions.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart' as Permissions;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyInvoice extends StatefulWidget {
  MyInvoice({key, required this.invoiceId, required this.invoicePdf});
  final String? invoiceId;
  final String? invoicePdf;

  @override
  State<MyInvoice> createState() => _MyInvoiceState();
}

class _MyInvoiceState extends State<MyInvoice> {
  bool _isDownloading = false;
  String? _currentTaskId;
  final ReceivePort _port = ReceivePort();
  final borderRadius = const BorderRadius.all(Radius.circular(10));

  @override
  void initState() {
    super.initState();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  bool _initDownloaderListener() {
    bool _isSuccess = false;
    logger.e('inside the iniit dowmloader');
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      Enum status = DownloadTaskStatus.fromInt(data[1]);
      logger.e(status);
      logger.i(status == DownloadTaskStatus.complete);
      if (status == DownloadTaskStatus.complete) {
        logger.e('from checking status $_isDownloading');
        _isSuccess = true;
      } else {
        _isSuccess = false;
      }
    });
    return _isSuccess;
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  Future<void> getMyInvoicePdf(String url, String fileName) async {
    logger.e('from get my invoice function $_isDownloading');
    setState(() => _isDownloading = true);

    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;
    try {
      final Enum storageStatus = android.version.sdkInt < 33
          ? await Permissions.Permission.storage.request()
          : PermissionStatus.granted;
      logger.i(storageStatus);
      logger.i(PermissionStatus.granted);
      logger.i(storageStatus == Permissions.PermissionStatus.granted);
      if (storageStatus == Permissions.PermissionStatus.granted) {
        Directory? directory = await getExternalStorageDirectory();
        String newPath = "${directory!.path}/Download";
        Directory downloadDirectory = Directory(newPath);
        if (!await downloadDirectory.exists()) {
          await downloadDirectory.create(recursive: true);
        }
        final filePath = "$newPath/";
        if (!url.startsWith('http://') && !url.startsWith('https://')) {
          url = 'https:' + url;
        }
        final pdfname = '${widget.invoiceId}.pdf';
        final Permissions.PermissionStatus status =
            await Permissions.Permission.notification.request();
        if (status.isDenied) {
          return;
        }
        final taskId = await FlutterDownloader.enqueue(
            url: url,
            savedDir: filePath,
            fileName: pdfname,
            showNotification: true,
            openFileFromNotification: true,
            saveInPublicStorage: true);
        _currentTaskId = taskId;
        final isSuccess = _initDownloaderListener();
        if (isSuccess) {
          setState(() {
            _isDownloading = false;
          });
        } else {
          setState(() {
            _isDownloading = true;
          });
        }
      } else {
        setState(
          () => _isDownloading = false,
        );
        // Consider showing an alert to the user that the permission is not granted
        logger.e('No storage permission granted.');
        return;
      }
    } catch (e) {
      logger.e('Error downloading file: $e');
      setState(
        () => _isDownloading = false,
      );
    }
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) async {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isDownloading
          ? null
          : () {
              logger.i('inside ontop function $_isDownloading');
              getMyInvoicePdf(widget.invoicePdf!, widget.invoiceId!);
            },
      child: Container(
        key: ValueKey(_isDownloading),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        height: DeviceInfo.getDeviceHeight(context) * 0.1,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: borderRadius,
        ),
        child: _isDownloading
            ? Center(
                key: ValueKey(_isDownloading),
                child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator()),
              )
            : Row(
                key: ValueKey(_isDownloading),
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.receipt,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Invoice No : ${widget.invoiceId}',
                            style: Theme.of(context).textTheme.bodyMedium!,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
      ),
    );
  }
}
