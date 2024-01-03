import 'package:alhomaidhi_customer_app/src/features/login/models/login_response.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseNotification {
  final String? title;
  final String? body;
  final Map<String, dynamic>? data;
  final DateTime? sentTime;
  final String? imageUrl;

  FirebaseNotification({
    this.title,
    this.body,
    this.data,
    this.sentTime,
    this.imageUrl,
  });

  factory FirebaseNotification.fromRemoteMessage(RemoteMessage message) {
    return FirebaseNotification(
      title: message.notification?.title,
      body: message.notification?.body,
      imageUrl: message.notification?.android
          ?.imageUrl, // Adjusted for potential null values
      data: message.data,
      sentTime: message.sentTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'data': data,
      'sentTime': sentTime?.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }

  factory FirebaseNotification.fromJson(Map<String, dynamic> json) {
    return FirebaseNotification(
      title: json['title'],
      body: json['body'],
      data: json['data'] as Map<String, dynamic>?,
      sentTime:
          json['sentTime'] != null ? DateTime.parse(json['sentTime']) : null,
      imageUrl: json['imageUrl'],
    );
  }
}
