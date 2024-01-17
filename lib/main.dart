import 'package:alhomaidhi_customer_app/src/utils/theme/theme.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/router/routes.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final globalContainer = ProviderContainer();
void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

  // FlutterDownloader.registerCallback(downloadCallback);

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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Alhomaidhi',
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      routerConfig: router,
    );
  }
}
