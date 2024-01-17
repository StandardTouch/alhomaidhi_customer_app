import 'package:alhomaidhi_customer_app/src/features/cart/models/cart_details_model.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/models/my_cart_response_model.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/services/cart_services.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/address/provider/address_provider.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void additemToCart(int productId, WidgetRef ref) async {
    state = state.copyWith(isLoading: true);
    await updateCart(productId.toString(), "1");
    ref.invalidate(myCartProvider);

    state = state.copyWith(
      isLoading: false,
    );
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
}

final cartDetailsProvider =
    StateNotifierProvider<CartDetailsNotifier, CartDetailsModel>((ref) {
  return CartDetailsNotifier();
});

final myCartProvider = FutureProvider<MyCartResponseModel>((ref) async {
  final response = await getCart();
  return response;
});
