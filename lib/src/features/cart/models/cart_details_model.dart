class CartDetailsModel {
  final bool isLoading;
  final int quantity;
  final Map<String, dynamic> deletingElement;
  final bool isAddressPresent;

  CartDetailsModel({
    this.isLoading = false,
    this.quantity = 0,
    this.deletingElement = const {
      "cartKey": "ss",
      "isDeleting": false,
    },
    this.isAddressPresent = false,
  });

  CartDetailsModel copyWith(
      {bool? isLoading,
      int? quantity,
      bool? isDeleting,
      final Map<String, dynamic>? deletingElement,
      bool? isAddressPresent}) {
    return CartDetailsModel(
      isLoading: isLoading ?? this.isLoading,
      quantity: quantity ?? this.quantity,
      deletingElement: deletingElement ?? this.deletingElement,
      isAddressPresent: isAddressPresent ?? this.isAddressPresent,
    );
  }
}
