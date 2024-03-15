import 'package:Alhomaidhi/src/utils/constants/endpoints.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  bool _isLoading = true;
  final String addIsWebViewScript = '''
  var url = new URL(window.location.href);
  if (!url.searchParams.has('iswebView')) {
    url.searchParams.set('iswebView', 'true');
    window.location.href = url.toString();
  };
''';

  late final PlatformWebViewControllerCreationParams params;
  late WebViewController controller;

  void initializeController({required String initialUrl}) {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress >= 90) {
              setState(() {
                _isLoading = false;
              });
            }
            debugPrint('WebView is loading (progress : $progress%)');
          },
          // error is here - while checking isWebview
          onPageStarted: (String url) {
            // Uri uri = Uri.parse(url);
            // Map<String, dynamic> params = uri.queryParameters;

            // // Logging the initial request URL for debugging.
            // print("Request URL: ${uri.toString()}");
            // debugPrint('Page started loading: $url');
            // if (!params.containsKey('iswebView')) {
            //   // 'iswebView' not present, add it to the URL
            //   Uri modifiedUri = uri
            //       .replace(queryParameters: {...params, 'iswebView': 'true'});
            //   String modifiedUrl = modifiedUri.toString();
            //   print("Modified URL to include iswebView: $modifiedUrl");
            //   controller.loadRequest(modifiedUri);
            //   // Prevent default loading and use modified URL
            // }
          },
          onPageFinished: (String url) {
            controller.clearCache();
            // controller.runJavaScript(addIsWebViewScript);

            // controller.runJavaScript(addIsWebViewScript);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            Uri uri = Uri.parse(request.url);
            Map<String, dynamic> params = uri.queryParameters;
            // Handling specific navigation cases based on URL.
            if (uri.path.contains("/order-received")) {
              context.go("/success");
              return NavigationDecision.prevent;
            } else if (uri.path.contains("/cart")) {
              context.go("/cart");
              return NavigationDecision.prevent;
            } else if (uri.path.contains("checkout/") &&
                params.containsKey('payment_id')) {
              // This covers both 'tabby failure' and any checkout related failure.
              context.go("/failure");
              return NavigationDecision.prevent;
            }
            // Add other URL checks and corresponding actions here if needed.

            // 'iswebView' already exists, no modification needed, proceed with navigation
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..loadRequest(Uri.parse(initialUrl));
  }

  @override
  void initState() {
    super.initState();

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
        limitsNavigationsToAppBoundDomains: false,
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    controller = WebViewController.fromPlatformCreationParams(params);

    final String encodedToken = Uri.encodeComponent(widget.token);

    final String initialUrl =
        "https://alhomaidhigroup.com/custom-checkout?mo_jwt_token=$encodedToken&iswebView=true";
    initializeController(initialUrl: initialUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationHelper.translation(context)!.checkout),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          if (_isLoading)
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: const CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
