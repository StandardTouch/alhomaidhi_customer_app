class CartDetailsModel {
  final bool isLoading;
  final int quantity;
  final Map<String, dynamic> deletingElement;
  final bool isAddressPresent;
  final bool isCheckingOut;

  CartDetailsModel({
    this.isLoading = false,
    this.quantity = 0,
    this.deletingElement = const {
      "cartKey": "ss",
      "isDeleting": false,
    },
    this.isAddressPresent = false,
    this.isCheckingOut = false,
  });

  CartDetailsModel copyWith({
    bool? isLoading,
    int? quantity,
    bool? isDeleting,
    Map<String, dynamic>? deletingElement,
    bool? isAddressPresent,
    bool? isCheckingOut,
  }) {
    return CartDetailsModel(
      isLoading: isLoading ?? this.isLoading,
      quantity: quantity ?? this.quantity,
      deletingElement: deletingElement ?? this.deletingElement,
      isAddressPresent: isAddressPresent ?? this.isAddressPresent,
      isCheckingOut: isCheckingOut ?? this.isCheckingOut,
    );
  }
}
