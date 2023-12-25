import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
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
// import 'package:flutter_downloader/flutter_downloader.dart';

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
  double fileProgress = 0;
  bool isDownloading = false;
  final borderRadius = const BorderRadius.all(Radius.circular(10));

  Future<void> getMyInvoicePdf(String url, String fileName) async {
    final storageStatus = await checkStoragePermission();
    if (storageStatus != Permissions.PermissionStatus.granted) {
      return;
    }

    DownloadDestinations filePath = DownloadDestinations.publicDownloads;
    final pdfname = '${widget.invoiceId}.pdf';
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https:' + url;
    }
    //Also, you can enable or disable the log, this will help you track your download batches

    setState(() => isDownloading = true);

    await FileDownloader.downloadFile(
        url: url.trim(),
        downloadDestination: DownloadDestinations.publicDownloads,
        name: pdfname.trim(),
        onProgress: (fileName, progress) {
          setState(() {
            fileProgress = progress;
          });
        },
        onDownloadError: (errorMessage) {
          logger.e(errorMessage);
          setState(() => isDownloading = false);
        },
        notificationType: NotificationType.all);
    FileDownloader.setLogEnabled(true);
    setState(() => isDownloading = false);
  }

  Future<Permissions.PermissionStatus> checkStoragePermission() async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;
    return android.version.sdkInt < 33
        ? await Permissions.Permission.storage.request()
        : Permissions.PermissionStatus.granted;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !isDownloading
          ? () => getMyInvoicePdf(widget.invoicePdf!, widget.invoiceId!)
          : null,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        height: DeviceInfo.getDeviceHeight(context) * 0.1,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: borderRadius,
        ),
        child: isDownloading
            ? Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    value: fileProgress / 100,
                  ),
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
