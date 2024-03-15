import 'dart:isolate';
import 'dart:ui';
import 'dart:async';
import 'package:Alhomaidhi/src/utils/constants/endpoints.dart';
import 'package:Alhomaidhi/src/utils/helpers/device_info.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart' as permissions;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyInvoice extends StatefulWidget {
  final String invoiceId;
  final String invoicePdf;

  const MyInvoice(
      {super.key, required this.invoiceId, required this.invoicePdf});

  @override
  MyInvoiceState createState() => MyInvoiceState();
}

class MyInvoiceState extends State<MyInvoice> {
  bool _isDownloading = false;
  String? _taskId;
  final ReceivePort _port = ReceivePort();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    FlutterDownloader.registerCallback(downloadCallback);
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus.fromInt(data[1]);
      int progress = data[2];

      // Debugging logs
      logger.e('Download Task ID: $id, Status: $status, Progress: $progress');

      if (id == _taskId && status == DownloadTaskStatus.complete) {
        setState(() {
          _isDownloading = false;
        });
        logger.e('Download completed for task ID: $id');
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  Future<void> downloadInvoice(String url, String fileName) async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;
    final storageStatus = android.version.sdkInt < 33
        ? await permissions.Permission.storage.request()
        : PermissionStatus.granted;
    logger.e(storageStatus == permissions.PermissionStatus.granted);
    if (storageStatus == permissions.PermissionStatus.granted) {
      Directory? directory = await getExternalStorageDirectory();
      String newPath = "${directory!.path}/Download";
      Directory downloadDirectory = Directory(newPath);
      if (!await downloadDirectory.exists()) {
        await downloadDirectory.create(recursive: true);
      }
      final filePath = "$newPath/";
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = 'https:$url';
      }
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: filePath,
        fileName: 'Invoice-${widget.invoiceId}.pdf',
        showNotification: true,
        openFileFromNotification: true,
      );
      setState(() {
        _isDownloading = true;
        _taskId = taskId;
      });
      _timer = Timer(const Duration(seconds: 15), () {
        // Hide the progress indicator after 10 seconds
        setState(() {
          _isDownloading = false;
        });
      });
    } else {
      // Handle the scenario when user denies the storage permission
      logger.e('Storage permission denied');
    }
  }

  static void downloadCallback(String id, int status, int progress) {
    final SendPort? sendPort =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    sendPort?.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !_isDownloading
          ? () => downloadInvoice(widget.invoicePdf, widget.invoiceId)
          : null,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        height: DeviceInfo.getDeviceHeight(context) * 0.1,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: _isDownloading
            ? const Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(),
                ),
              )
            : Row(
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
                            '${TranslationHelper.translation(context)!.invoiceNo}: ${widget.invoiceId}',
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
