import 'package:Alhomaidhi/src/shared/services/auth_service.dart';
import 'package:Alhomaidhi/src/shared/widgets/top_snackbar.dart';
import 'package:Alhomaidhi/src/utils/constants/endpoints.dart';
import 'package:Alhomaidhi/src/utils/helpers/device_info.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SingleOrderCard extends ConsumerStatefulWidget {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final Function()? onPressed;
  final String? orderStatus;
  final bool isOrderPending;
  final borderRadius = const BorderRadius.only(
    topRight: Radius.circular(10),
    bottomRight: Radius.circular(10),
    bottomLeft: Radius.circular(10),
    topLeft: Radius.circular(10),
  );

  const SingleOrderCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.onPressed,
    required this.orderStatus,
    this.isOrderPending = false,
  });

  @override
  ConsumerState<SingleOrderCard> createState() => _SingleOrderCardState();
}

class _SingleOrderCardState extends ConsumerState<SingleOrderCard> {
  bool isLoading = false;
  void onCheckout() async {
    try {
      setState(() {
        isLoading = true;
      });
      // get credentials
      final updateCredentialsResponse = await getCredentials();
      final String username = updateCredentialsResponse["username"];
      final String password = updateCredentialsResponse["password"];
      logger.i("username: $username\npassword: $password");

      // generate token
      final getTokenResponse = await getPreCheckoutToken(username, password);
      final String token = getTokenResponse["jwt_token"] as String;
      logger.i("This is the token: $token");
      if (!context.mounted) return;
      // pass token to get request
      context.pushNamed("checkout", pathParameters: {
        "token": token,
      });
    } catch (err) {
      if (!context.mounted) return;
      getSnackBar(
        // ignore: use_build_context_synchronously
        context: context,
        // ignore: use_build_context_synchronously
        message: TranslationHelper.translation(context)!.errorWhileCheckingOut,
        type: SNACKBARTYPE.error,
      );
    } finally {
      // state = state.copyWith(isCheckingOut: false);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        height: DeviceInfo.getDeviceHeight(context) * 0.1,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: widget.borderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  widget.imageUrl!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: widget.orderStatus == 'wc-completed'
                              ? Colors.black
                              : const Color.fromARGB(255, 3, 104, 45)),
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Text(
                        widget.subtitle!,
                        style: Theme.of(context).textTheme.labelMedium,
                        // overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            (widget.isOrderPending)
                ? SizedBox(
                    height: double.infinity,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(9),
                                bottomRight: Radius.circular(9))),
                      ),
                      icon: (isLoading)
                          ? const CircularProgressIndicator()
                          : const Icon(
                              Icons.payment,
                              color: Colors.black,
                              size: 40,
                            ),
                      onPressed: (isLoading) ? null : onCheckout,
                    ),
                  )
                : Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).primaryColor,
                  )
          ],
        ),
      ),
    );
  }
}
