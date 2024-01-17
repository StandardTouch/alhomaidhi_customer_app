import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key, required this.token});
  final String token;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
            "https://alhomdelivery.standardtouch.com/custom-checkout?mo_jwt_token=$token",
      ),
    );
  }
}
