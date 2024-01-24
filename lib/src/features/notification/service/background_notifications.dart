import 'dart:ui';

import 'package:alhomaidhi_customer_app/src/features/notification/model/firebase_notification.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

VoidCallback? onNewNotification;
// Top-level function to handle background messages
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");

  // Convert message to a custom notification object
  final notification = FirebaseNotification.fromRemoteMessage(message);

  // Save the notification
  await saveNotificationInBackground(notification);
  onNewNotification?.call();
}

Future<void> saveNotificationInBackground(
    FirebaseNotification notification) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final notificationsJson = prefs.getStringList('saved_notifications') ?? [];
    notificationsJson.add(json.encode(notification.toJson()));
    await prefs.setStringList('saved_notifications', notificationsJson);
    final notificationsJson2 = prefs.getStringList('saved_notifications') ?? [];
    print("Saved notifications JSON: $notificationsJson2"); // Diagnostic log
  } catch (e) {
    print("Error saving notification: $e");
  }
}

Future<List<FirebaseNotification>> getSavedNotifications() async {
  final prefs = await SharedPreferences.getInstance();
  final notificationsJson = prefs.getStringList('saved_notifications') ?? [];
  print("Saved notifications JSON: $notificationsJson"); // Diagnostic log

  return notificationsJson.map((jsonStr) {
    return FirebaseNotification.fromJson(json.decode(jsonStr));
  }).toList();
}



// // Define FirebaseNotification and fromRemoteMessage according to your needs
// class FirebaseNotification {
//   // Add fields and a constructor that suits your notification data

//   FirebaseNotification.fromRemoteMessage(RemoteMessage message) {
//     // Initialize your notification object from the RemoteMessage
//   }

//   Map<String, dynamic> toJson() {
//     // Convert your notification to a JSON map
//   }

//   static FirebaseNotification fromJson(Map<String, dynamic> json) {
//     // Create a notification object from a JSON map
//   }
// }
