import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  print(
                      "theme mode before pressing button: ${EasyDynamicTheme.of(context).themeMode}");
                  EasyDynamicTheme.of(context).changeTheme();
                  print(
                      "theme mode after pressing button: ${EasyDynamicTheme.of(context).themeMode}");
                },
                child: Text("change theme"))
          ],
        ),
      ),
    );
  }
}
