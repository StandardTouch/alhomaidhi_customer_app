import 'dart:io';

import 'package:Alhomaidhi/firebase_options.dart';
import 'package:Alhomaidhi/src/features/notification/service/background_notifications.dart';
import 'package:Alhomaidhi/src/shared/providers/language_provider.dart';
import 'package:Alhomaidhi/src/utils/theme/theme.dart';
import 'package:Alhomaidhi/src/utils/config/router/routes.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final globalContainer = ProviderContainer();
Future multipleRegistration() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  if (Platform.isIOS) {
    String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (apnsToken != null) {
      // await _firebaseMessaging.subscribeToTopic("notificationChannel");
      try {
        await FirebaseMessaging.instance.subscribeToTopic('order-status');
      } on FirebaseException catch (e) {
        debugPrint("George here is the error: $e");
      }
    } else {
      await Future<void>.delayed(const Duration(seconds: 3));
      apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        try {
          await FirebaseMessaging.instance.subscribeToTopic('order-status');
        } on FirebaseException catch (e) {
          debugPrint("George here is the error: $e");
        }
      }
    }
  } else {
    try {
      await FirebaseMessaging.instance.subscribeToTopic('order-status');
    } on FirebaseException catch (e) {
      debugPrint("George here is the error: $e");
    }
  }
  // WidgetsFlutterBinding.ensureInitialized();
}

void main() async {
  await dotenv.load();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false, ignoreSsl: true);
  await multipleRegistration();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // FlutterDownloader.registerCallback(downloadCallback);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    UncontrolledProviderScope(
      container: globalContainer,
      child: EasyDynamicThemeWidget(
        initialThemeMode: ThemeMode.light,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          final isArabic = ref.watch(languageProvider);
          final locale = isArabic ? const Locale('ar') : const Locale('en');

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Alhomaidhi',
            theme: lightThemeData,
            darkTheme: darkThemeData,
            themeMode: EasyDynamicTheme.of(context).themeMode,
            routerConfig: router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
          );
        },
      ),
    );
  }
}
