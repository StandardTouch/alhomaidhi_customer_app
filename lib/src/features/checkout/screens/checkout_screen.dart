import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key, required this.token});
  final String token;

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Stack(
        children: [
          WebView(
            onWebResourceError: (err) {
              logger.e("Error: ${err.description}");
            },
            onPageFinished: (isFinished) {
              setState(() {
                isLoading = false;
              });
            },
            navigationDelegate: (request) {
              if (request.url.contains("/order-received")) {
                context.go("/success");
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl:
                "https://alhomdelivery.standardtouch.com/custom-checkout?mo_jwt_token=${widget.token}",
          ),
          if (isLoading)
            Container(
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              child: const SizedBox(
                  height: 40, width: 40, child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
