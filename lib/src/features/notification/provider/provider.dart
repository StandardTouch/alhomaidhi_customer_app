import 'package:alhomaidhi_customer_app/src/features/notification/model/firebase_notification.dart';
import 'package:alhomaidhi_customer_app/src/features/notification/service/notification_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// providers.dart

// Provider for NotificationService
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(ref);
});

// Provider for the current notification state
final notificationProvider =
    StateProvider<FirebaseNotification?>((ref) => null);
