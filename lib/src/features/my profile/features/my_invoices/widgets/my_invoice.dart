import 'dart:isolate';
import 'dart:ui';
import 'dart:async';
import 'package:background_downloader/background_downloader.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart' as Permissions;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyInvoice extends StatefulWidget {
  const MyInvoice(
      {super.key, required this.invoiceId, required this.invoicePdf});

  const MyInvoice({Key? key, required this.invoiceId, required this.invoicePdf})
      : super(key: key);

  @override
  _MyInvoiceState createState() => _MyInvoiceState();
}

class _MyInvoiceState extends State<MyInvoice> {
  final borderRadius = const BorderRadius.only(
    topRight: Radius.circular(10),
    bottomRight: Radius.circular(10),
    bottomLeft: Radius.circular(10),
    topLeft: Radius.circular(10),
  );

  Future<void> getMyInvoicePdf(String url, String fileName) async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;
    try {
      final storageStatus = android.version.sdkInt < 33
          ? await Permission.storage.request()
          : PermissionStatus.granted;
      // Requesting storage permission
      // var status = await Permission.storage.request();
      logger.i(storageStatus);
      if (storageStatus == PermissionStatus.granted) {
        // Getting the external storage directory
        Directory? directory = await getExternalStorageDirectory();
        String newPath = "";
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/$folder";
          } else {
            break;
          }
        }
        newPath = "$newPath/Download";
        directory = Directory(newPath);

        // The file's path where it will be saved
        final filePath = directory.path;
        if (!url.startsWith('http://') && !url.startsWith('https://')) {
          url = 'https:' + url;
        }
        // Downloading using Dio
        // var dio = Dio();
        // await dio.download(url, filePath, onReceiveProgress: (received, total) {
        //   if (total != -1) {
        //     // Calculate the progress percentage
        //     int progress = ((received / total) * 100).toInt();
        //     // Call a function to update the notification with the current progress
        //     showDownloadNotification(progress, false);
        //   }
        // });

        final pdfname = '${widget.invoiceId}.pdf';
        logger.i(url);
        final PermissionStatus status = await Permission.notification.request();

        if (status.isGranted) {
          await FlutterDownloader.enqueue(
              url: url,
              savedDir: filePath,
              fileName: pdfname,
              showNotification: true,
              saveInPublicStorage: true,
              openFileFromNotification: true);
          logger.i('Downloaded file path: $filePath');
        }
      } else {
        logger.e('No storage permission granted.');
      }
    } catch (e) {
      logger.e('Error downloading file: $e');
    }
  }

  ReceivePort _port = ReceivePort();

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
        ? await Permissions.Permission.storage.request()
        : PermissionStatus.granted;
    logger.e(storageStatus == Permissions.PermissionStatus.granted);
    if (storageStatus == Permissions.PermissionStatus.granted) {
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
      print('Storage permission denied');
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
