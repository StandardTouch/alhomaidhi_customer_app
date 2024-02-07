import 'dart:convert';
import 'dart:io' show Platform;
import 'package:alhomaidhi_customer_app/src/features/notification/model/firebase_notification.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/dio/dio_client.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/auth_helper.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  final ProviderRef ref;
  NotificationService(this.ref);
  bool _isListenerSetUp = false;
  VoidCallback? onNewNotification;

  Future<void> clearAllNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_notifications');
  }

  Future<void> init() async {
    final fcm = FirebaseMessaging.instance;
    // Requesting permission for notifications
    NotificationSettings settings = await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('User granted permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final fcmToken = await fcm.getToken();
      debugPrint('FCM Token: $fcmToken');
      if (fcmToken != null) {
        await _sendTokenToServer(fcmToken);
      }
    }
    _setUpMessageListeners(fcm);
  }

  Future<void> _sendTokenToServer(String token) async {
    try {
      final userDetails = await AuthHelper.getAuthDetails();
      final jsonResponse = await dioClient.post(APIEndpoints.sendFcmToken,
          options: Options(headers: {
            "Authorization": userDetails.token,
            "user_id": userDetails.userId,
          }),
          data: {"notification_token": token});

      if (jsonResponse.statusCode == 200) {
        logger.e('Token sent to server successfully');
      } else {
        debugPrint('Failed to send token to server: ${jsonResponse.data}');
      }
    } catch (e) {
      debugPrint('Error sending token to server: $e');
    }
  }

  void _setUpMessageListeners(FirebaseMessaging fcm) {
    if (_isListenerSetUp) return;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final notification = FirebaseNotification.fromRemoteMessage(message);
      await saveNotification(notification);

      onNewNotification?.call();
    });

    // Include other message handlers as needed
    _isListenerSetUp = true;
  }

  Future<void> saveNotification(FirebaseNotification notification) async {
    // print("sent time ${notification.sentTime}");
    final prefs = await SharedPreferences.getInstance();
    final notificationsJson = prefs.getStringList('saved_notifications') ?? [];
    notificationsJson.add(json.encode(notification.toJson()));
    await prefs.setStringList('saved_notifications', notificationsJson);
  }

  Future<List<FirebaseNotification>> getSavedNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final notificationsJson = prefs.getStringList('saved_notifications') ?? [];
    // print("Saved notifications JSON: $notificationsJson"); // Diagnostic log

    final notifications = notificationsJson.map((jsonStr) {
      return FirebaseNotification.fromJson(json.decode(jsonStr));
    }).toList();

    if (Platform.isIOS) {
      return notifications;
    } else {
      notifications.sort(
          (a, b) => b.sentTime?.compareTo(a.sentTime ?? DateTime(0)) ?? 0);

      final cutoff = DateTime.now().subtract(const Duration(days: 3));
      final filteredNotifications = notifications
          .where((n) => n.sentTime != null && n.sentTime!.isAfter(cutoff))
          .toList();

      // print("Filtered notifications: $filteredNotifications"); // Diagnostic log

      return filteredNotifications;
    }
  }
}
