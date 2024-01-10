class MyCartResponseModel {
  String? status;
  Message? message;
  String? errorMessage;

  MyCartResponseModel({
    this.status,
    this.message,
    this.errorMessage,
  });

  MyCartResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["message"] is Map) {
      message =
          json["message"] == null ? null : Message.fromJson(json["message"]);
    } else if (json["message"] is String) {
      errorMessage = json["message"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    if (message != null) {
      _data["message"] = message?.toJson();
    }
    return _data;
  }
}

class Message {
  CartTotals? cartTotals;
  List<Cart>? cart;

  Message({this.cartTotals, this.cart});

  Message.fromJson(Map<String, dynamic> json) {
    if (json["cart_totals"] is Map) {
      cartTotals = json["cart_totals"] == null
          ? null
          : CartTotals.fromJson(json["cart_totals"]);
    }
    if (json["cart"] is List) {
      cart = json["cart"] == null
          ? null
          : (json["cart"] as List).map((e) => Cart.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (cartTotals != null) {
      _data["cart_totals"] = cartTotals?.toJson();
    }
    if (cart != null) {
      _data["cart"] = cart?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Cart {
  String? key;
  String? quantity;
  int? lineSubtotal;
  int? lineSubtotalTax;
  int? lineTotal;
  int? lineTax;
  ProductDetails? productDetails;

  Cart(
      {this.key,
      this.quantity,
      this.lineSubtotal,
      this.lineSubtotalTax,
      this.lineTotal,
      this.lineTax,
      this.productDetails});

  Cart.fromJson(Map<String, dynamic> json) {
    if (json["key"] is String) {
      key = json["key"];
    }
    if (json["quantity"] is String) {
      quantity = json["quantity"];
    }
    if (json["line_subtotal"] is int) {
      lineSubtotal = json["line_subtotal"];
    }
    if (json["line_subtotal_tax"] is int) {
      lineSubtotalTax = json["line_subtotal_tax"];
    }
    if (json["line_total"] is int) {
      lineTotal = json["line_total"];
    }
    if (json["line_tax"] is int) {
      lineTax = json["line_tax"];
    }
    if (json["product_details"] is Map) {
      productDetails = json["product_details"] == null
          ? null
          : ProductDetails.fromJson(json["product_details"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["key"] = key;
    _data["quantity"] = quantity;
    _data["line_subtotal"] = lineSubtotal;
    _data["line_subtotal_tax"] = lineSubtotalTax;
    _data["line_total"] = lineTotal;
    _data["line_tax"] = lineTax;
    if (productDetails != null) {
      _data["product_details"] = productDetails?.toJson();
    }
    return _data;
  }
}

class ProductDetails {
  int? productId;
  String? name;
  String? description;
  String? shortDescription;
  int? stockQuantity;
  List<Images>? images;

  ProductDetails(
      {this.productId,
      this.name,
      this.description,
      this.shortDescription,
      this.stockQuantity,
      this.images});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    if (json["product_id"] is int) {
      productId = json["product_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["short_description"] is String) {
      shortDescription = json["short_description"];
    }
    if (json["stock_quantity"] is int) {
      stockQuantity = json["stock_quantity"];
    }
    if (json["images"] is List) {
      images = json["images"] == null
          ? null
          : (json["images"] as List).map((e) => Images.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["product_id"] = productId;
    _data["name"] = name;
    _data["description"] = description;
    _data["short_description"] = shortDescription;
    _data["stock_quantity"] = stockQuantity;
    if (images != null) {
      _data["images"] = images?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Images {
  int? id;
  String? name;
  String? src;
  String? alt;

  Images({this.id, this.name, this.src, this.alt});

  Images.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["src"] is String) {
      src = json["src"];
    }
    if (json["alt"] is String) {
      alt = json["alt"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["src"] = src;
    _data["alt"] = alt;
    return _data;
  }
}

class CartTotals {
  String? subtotal;
  int? subtotalTax;
  String? shippingTotal;
  int? shippingTax;
  int? discountTotal;
  int? discountTax;
  String? cartContentsTotal;
  double? cartContentsTax;
  String? total;
  double? totalTax;

  CartTotals(
      {this.subtotal,
      this.subtotalTax,
      this.shippingTotal,
      this.shippingTax,
      this.discountTotal,
      this.discountTax,
      this.cartContentsTotal,
      this.cartContentsTax,
      this.total,
      this.totalTax});

  CartTotals.fromJson(Map<String, dynamic> json) {
    if (json["subtotal"] is String) {
      subtotal = json["subtotal"];
    }
    if (json["subtotal_tax"] is int) {
      subtotalTax = json["subtotal_tax"];
    }
    if (json["shipping_total"] is String) {
      shippingTotal = json["shipping_total"];
    }
    if (json["shipping_tax"] is int) {
      shippingTax = json["shipping_tax"];
    }
    if (json["discount_total"] is int) {
      discountTotal = json["discount_total"];
    }
    if (json["discount_tax"] is int) {
      discountTax = json["discount_tax"];
    }
    if (json["cart_contents_total"] is String) {
      cartContentsTotal = json["cart_contents_total"];
    }
    if (json["cart_contents_tax"] is double) {
      cartContentsTax = json["cart_contents_tax"];
    }
    if (json["total"] is String) {
      total = json["total"];
    }
    if (json["total_tax"] is double) {
      totalTax = json["total_tax"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["subtotal"] = subtotal;
    _data["subtotal_tax"] = subtotalTax;
    _data["shipping_total"] = shippingTotal;
    _data["shipping_tax"] = shippingTax;
    _data["discount_total"] = discountTotal;
    _data["discount_tax"] = discountTax;
    _data["cart_contents_total"] = cartContentsTotal;
    _data["cart_contents_tax"] = cartContentsTax;
    _data["total"] = total;
    _data["total_tax"] = totalTax;
    return _data;
  }
}
