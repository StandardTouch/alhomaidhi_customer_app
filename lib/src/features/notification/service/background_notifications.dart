import 'dart:ui';

import 'package:Alhomaidhi/src/features/notification/model/firebase_notification.dart';
import 'package:Alhomaidhi/src/utils/constants/endpoints.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

VoidCallback? onNewNotification;
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print("Handling a background message: ${message.messageId}");
  if (message.data.containsKey('orderId')) {
    final orderId = message.data['orderId'];
    // ignore: unused_local_variable
    final productIndex = message.data['productIndex'] ?? '0';
    logger.e(orderId);

    // getMyOrderDetails(orderId);
    // navigatorKey.currentContext?.pushNamed(
    //   "my_order_details",
    //   pathParameters: {
    //     "orderId": orderId,
    //     "productIndex": productIndex,
    //   },
    // );
  }

  final notification = FirebaseNotification.fromRemoteMessage(message);

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
    // ignore: unused_local_variable
    final notificationsJson2 = prefs.getStringList('saved_notifications') ?? [];
    // print(
    //     "Save notification in background  JSON: $notificationsJson2"); // Diagnostic log
  } catch (e) {
    // print("Error saving notification: $e");
  }
}

Future<List<FirebaseNotification>> getSavedNotifications() async {
  final prefs = await SharedPreferences.getInstance();
  final notificationsJson = prefs.getStringList('saved_notifications') ?? [];
  // print(
  //     "Saved Background notifications JSON: $notificationsJson"); // Diagnostic log

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

