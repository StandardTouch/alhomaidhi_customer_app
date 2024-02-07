import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotification {
  final String? title;
  final String? body;
  final Map<String, dynamic>? data;
  final DateTime? sentTime;
  final String? imageUrl;
  final String? orderId;
  final String? productIndex;

  FirebaseNotification({
    this.title,
    this.body,
    this.data,
    this.sentTime,
    this.imageUrl,
    this.orderId,
    this.productIndex,
  });

  factory FirebaseNotification.fromRemoteMessage(RemoteMessage message) {
    return FirebaseNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        imageUrl: _getPlatformSpecificImageUrl(message),
        data: message.data,
        sentTime: message.sentTime,
        orderId: message.data['orderId'],
        productIndex: message.data['productIndex']);
  }

  static String? _getPlatformSpecificImageUrl(RemoteMessage message) {
    if (message.notification?.android != null) {
      return message.notification?.android?.imageUrl;
    }

    if (message.notification?.apple != null) {
      return message.notification?.apple?.imageUrl;
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'data': data,
      'sentTime': sentTime?.toIso8601String(),
      'imageUrl': imageUrl,
      'orderId': orderId,
      'productIndex': productIndex
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
        orderId: json['orderId'],
        productIndex: json['productIndex']);
  }
}
