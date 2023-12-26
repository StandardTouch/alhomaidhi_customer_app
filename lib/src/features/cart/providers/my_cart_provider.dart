import 'package:alhomaidhi_customer_app/src/features/cart/models/cart_details_model.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/models/my_cart_response_model.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/services/cart_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartDetailsNotifier extends StateNotifier<CartDetailsModel> {
  CartDetailsNotifier() : super(CartDetailsModel(quantity: 0));

  void incrementCartItem() {
    state = state.copyWith(quantity: state.quantity + 1);
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
