import 'package:Alhomaidhi/src/utils/constants/assets.dart';
import 'package:Alhomaidhi/src/utils/exceptions/homaidhi_exception.dart';
import 'package:Alhomaidhi/src/utils/helpers/auth_helper.dart';
import 'package:Alhomaidhi/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NetworkErrorScreen extends ConsumerStatefulWidget {
  const NetworkErrorScreen({super.key});

  @override
  ConsumerState<NetworkErrorScreen> createState() => _NetworkErrorScreenState();
}

class _NetworkErrorScreenState extends ConsumerState<NetworkErrorScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.5,
            child: Image.asset(
              Assets.errorImage,
              width: DeviceInfo.getDeviceWidth(context) * 0.5,
            ),
          ),
          const Gap(10),
          const Text(
            "There seems to be an issue with your Connection. Please try refreshing",
            textAlign: TextAlign.center,
          ),
          const Gap(10),
          ElevatedButton.icon(
            onPressed: isLoading
                ? null
                : () async {
                    try {
                      setState(() {
                        isLoading = true;
                      });
                      final isLoggedIn = await AuthHelper.isUserLoggedIn();
                      if (!context.mounted) return;
                      (isLoggedIn == "DELAPP00")
                          ? context.go("/home")
                          : (isLoggedIn == "DELAPP99")
                              ? context.go("/password-reset")
                              : context.go("login");

                      setState(() {
                        isLoading = false;
                      });
                    } on HomaidhiException catch (_) {
                      // catch empty
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
            icon: const Icon(Icons.refresh),
            label: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Text("Refresh"),
          )
        ],
      ),
    );
  }
}
