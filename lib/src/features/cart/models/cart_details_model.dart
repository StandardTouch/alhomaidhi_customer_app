class CartDetailsModel {
  final bool isLoading;
  final int quantity;

  final Map<String, dynamic> deletingElement;
  CartDetailsModel({
    this.isLoading = false,
    this.quantity = 0,
    this.deletingElement = const {
      "cartKey": "ss",
      "isDeleting": false,
    },
  });

  CartDetailsModel copyWith(
      {bool? isLoading,
      int? quantity,
      bool? isDeleting,
      final Map<String, dynamic>? deletingElement}) {
    return CartDetailsModel(
      isLoading: isLoading ?? this.isLoading,
      quantity: quantity ?? this.quantity,
      deletingElement: deletingElement ?? this.deletingElement,
    );
  }
}
