// ignore_for_file: use_build_context_synchronously

import 'package:Alhomaidhi/src/features/cart/models/cart_details_model.dart';
import 'package:Alhomaidhi/src/features/cart/models/my_cart_response_model.dart';
import 'package:Alhomaidhi/src/features/cart/services/cart_services.dart';
import 'package:Alhomaidhi/src/features/my%20profile/features/address/provider/address_provider.dart';
import 'package:Alhomaidhi/src/shared/services/auth_service.dart';
import 'package:Alhomaidhi/src/shared/widgets/bottom_bar.dart';
import 'package:Alhomaidhi/src/shared/widgets/top_snackbar.dart';
import 'package:Alhomaidhi/src/utils/constants/endpoints.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CartDetailsNotifier extends StateNotifier<CartDetailsModel> {
  CartDetailsNotifier() : super(CartDetailsModel(isLoading: false));

  void updateCartItem(int productId, int quantity, WidgetRef ref) async {
    state = state.copyWith(isLoading: true);
    await updateCart(productId.toString(), quantity.toString());
    final cart = ref.refresh(myCartProvider);
    cart.whenData(
      (value) {
        Future.delayed(
          const Duration(seconds: 4, milliseconds: 500),
          () {
            state = state.copyWith(
              quantity: quantity,
              isLoading: false,
            );
          },
        );
      },
    );
  }

  void setAddressToTrue() {
    state = state.copyWith(isAddressPresent: true);
  }

  void setPasswordPresentToTrue() {
    state = state.copyWith(isPasswordPresent: true);
  }

  void additemToCart(int productId, WidgetRef ref, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    await updateCart(productId.toString(), "1");
    ref.invalidate(myCartProvider);

    state = state.copyWith(
      isLoading: false,
    );
    final snackbar = SnackBar(
      content: Text(TranslationHelper.translation(context)!.itemPlacedInCart),
      action: SnackBarAction(
        label: TranslationHelper.translation(context)!.gotoCart,
        onPressed: () async {
          await navigateToCart(context);
        },
      ),
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void checkAddress(WidgetRef ref) async {
    final address = await ref.read(addressProvider.future);
    if (address.message!.address1 != "") {
      state = state.copyWith(isAddressPresent: true);
    }
  }

  void deleteCartItem(String cartKey, WidgetRef ref) async {
    logger.d("Cart Key: $cartKey");

    state = state
        .copyWith(deletingElement: {"cartKey": cartKey, "isDeleting": true});
    await deleteItemFromCart(cartKey);
    final cart = ref.refresh(myCartProvider);
    cart.whenData(
      (value) {
        Future.delayed(
          const Duration(seconds: 4),
          () {
            state = state.copyWith(
              deletingElement: {"cartKey": cartKey, "isDeleting": false},
            );
          },
        );
      },
    );
  }

  void onCheckout(BuildContext context) async {
    try {
      state = state.copyWith(isCheckingOut: true);
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
        context: context,
        message: "Error While checking out",
        type: SNACKBARTYPE.error,
      );
    } finally {
      state = state.copyWith(isCheckingOut: false);
    }
  }
}

final cartDetailsProvider =
    StateNotifierProvider<CartDetailsNotifier, CartDetailsModel>((ref) {
  return CartDetailsNotifier();
});

final myCartProvider = FutureProvider<MyCartResponseModel>((ref) async {
  final response = await getCart();
  return response;
});
