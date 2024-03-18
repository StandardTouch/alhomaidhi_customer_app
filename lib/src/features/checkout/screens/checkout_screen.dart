import 'package:Alhomaidhi/src/utils/constants/endpoints.dart';
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
  late WebViewController webViewController;
  Future<void> clearCookies() async {
    final CookieManager cookieManager = CookieManager();
    await cookieManager.clearCookies();
  }

  @override
  void initState() {
    super.initState();
    clearCookies();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            zoomEnabled: false,
            onWebResourceError: (err) {
              logger.e("Error: ${err.description}");
            },
            onPageFinished: (isFinished) {
              Future.delayed(const Duration(seconds: 4), () {
                setState(() {
                  isLoading = false;
                });
              });
            },
            navigationDelegate: (request) {
              String modifiedUrl = request.url;

              // Check if the URL already has query parameters
              if (modifiedUrl.contains("?")) {
                modifiedUrl += "&iswebView=true";
              } else {
                modifiedUrl += "?iswebView=true";
              }
              // HYPERPAY FAILURE URL
              // https://alhomdelivery.standardtouch.com/checkout/order-pay/1829/?key=wc_order_cVFgG6qogXMWU&callback=true&transaction-key=15054021&id=CAD59C3188A2532C9B997295744AE27A.prod01-vm-tx07&resourcePath=%2Fv1%2Fcheckouts%2FCAD59C3188A2532C9B997295744AE27A.prod01-vm-tx07%2Fpayment
              // hyperpay processing url
              // https://alhomaidhigroup.com/checkout/order-pay/6859/?key=wc_order_oddcNYvyYoCIl
              if (modifiedUrl.contains("/order-received")) {
                context.go("/success");
                return NavigationDecision.prevent;
              }
              if (modifiedUrl.contains("/cart")) {
                context.go("/cart");
                return NavigationDecision.prevent;
              }
              // hyperpay failure - issues faced. temp ignored.

              // tabby failure
              else if (modifiedUrl.contains("checkout/?payment_id")) {
                context.go("/failure");
                return NavigationDecision.prevent;
              }
              logger.i("request url: $modifiedUrl");
              webViewController.loadUrl(modifiedUrl);
              return NavigationDecision
                  .prevent; // Prevent default behavior since we're manually loading the URL

              // return NavigationDecision.navigate;
            },
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl:
                "https://alhomaidhigroup.com/custom-checkout?mo_jwt_token=${widget.token}",
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
