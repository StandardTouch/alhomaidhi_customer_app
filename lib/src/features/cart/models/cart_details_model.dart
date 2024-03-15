class CartDetailsModel {
  final bool isLoading;
  final int quantity;
  final Map<String, dynamic> deletingElement;
  final bool isAddressPresent;
  final bool isCheckingOut;
  final bool isPasswordPresent;

  CartDetailsModel({
    this.isLoading = false,
    this.quantity = 0,
    this.deletingElement = const {
      "cartKey": "ss",
      "isDeleting": false,
    },
    this.isAddressPresent = false,
    this.isCheckingOut = false,
    this.isPasswordPresent = false,
  });

  CartDetailsModel copyWith({
    bool? isLoading,
    int? quantity,
    bool? isDeleting,
    Map<String, dynamic>? deletingElement,
    bool? isAddressPresent,
    bool? isCheckingOut,
    bool? isPasswordPresent,
  }) {
    return CartDetailsModel(
      isLoading: isLoading ?? this.isLoading,
      quantity: quantity ?? this.quantity,
      deletingElement: deletingElement ?? this.deletingElement,
      isAddressPresent: isAddressPresent ?? this.isAddressPresent,
      isCheckingOut: isCheckingOut ?? this.isCheckingOut,
      isPasswordPresent: isPasswordPresent ?? this.isAddressPresent,
    );
  }
}
