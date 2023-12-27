import 'package:alhomaidhi_customer_app/src/features/cart/models/cart_details_model.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/models/my_cart_response_model.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/services/cart_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartDetailsNotifier extends StateNotifier<CartDetailsModel> {
  CartDetailsNotifier() : super(CartDetailsModel(quantity: 0));

  void updateCartItem(int productId, int quantity) async {
    state = state.copyWith(isLoading: true);
    await updateCart(productId.toString(), quantity.toString());
    state = state.copyWith(
      quantity: quantity,
      isLoading: false,
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
