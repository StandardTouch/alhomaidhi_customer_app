class CartDetailsModel {
  final bool? isLoading;
  final int quantity;
  CartDetailsModel({this.isLoading, this.quantity = 0});

  CartDetailsModel copyWith({bool? isLoading, int? quantity}) {
    return CartDetailsModel(
      isLoading: isLoading ?? this.isLoading,
      quantity: quantity ?? this.quantity,
    );
  }
}
