import 'package:alhomaidhi_customer_app/src/features/login/models/login_response.dart';
import 'package:alhomaidhi_customer_app/src/features/notification/model/firebase_notification.dart';
import 'package:alhomaidhi_customer_app/src/features/notification/provider/provider.dart';
import 'package:alhomaidhi_customer_app/src/features/notification/service/background_notifications.dart';
import 'package:alhomaidhi_customer_app/src/features/notification/widgets/no_notification.dart';
import 'package:alhomaidhi_customer_app/src/features/notification/widgets/notification.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _NotificationScreenState();
  }
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    final notificationService = ref.read(notificationServiceProvider);
    notificationService.onNewNotification = () {
      setState(() {});
    };

    onNewNotification = () {
      setState(() {});
    };
    notificationService.init();
  }

  // @override
  // void dispose() {
  //   final notificationService = ref.read(notificationServiceProvider);
  //   notificationService.onNewNotification = null;
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    ref.read(notificationServiceProvider).init();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await ref
                    .read(notificationServiceProvider)
                    .clearAllNotifications();
                setState(() {}); // Rebuild the widget to reflect changes
              },
            ),
          ],
        ),
        body: FutureBuilder<List<FirebaseNotification>>(
          future: ref.read(notificationServiceProvider).getSavedNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const NoNotification(); // Custom widget for "no notifications"
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final notification = snapshot.data![index];
                  return SingleNotification(
                    title: notification.title,
                    body: notification.body,
                    imageUrl: notification.imageUrl,
                    sentTime: notification.sentTime ?? DateTime.now(),
                  );
                },
              );
            }
          },
        ));
  }
}
