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
            zoomEnabled: false,
            onWebResourceError: (err) {
              logger.e("Error: ${err.description}");
            },
            onPageFinished: (isFinished) {
              Future.delayed(const Duration(seconds: 10), () {
                setState(() {
                  isLoading = false;
                });
              });
            },
            navigationDelegate: (request) {
              // TODO - add hyperpay failure gateway redirect
              // HYPERPAY FAILURE URL
// https://alhomdelivery.standardtouch.com/checkout/order-pay/1829/?key=wc_order_cVFgG6qogXMWU&callback=true&transaction-key=15054021&id=CAD59C3188A2532C9B997295744AE27A.prod01-vm-tx07&resourcePath=%2Fv1%2Fcheckouts%2FCAD59C3188A2532C9B997295744AE27A.prod01-vm-tx07%2Fpayment
              if (request.url.contains("/order-received")) {
                context.go("/success");
                return NavigationDecision.prevent;
              }
              logger.i(request.url);
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
