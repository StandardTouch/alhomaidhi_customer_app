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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    if (message != null) {
      data["message"] = message?.toJson();
    }
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cartTotals != null) {
      data["cart_totals"] = cartTotals?.toJson();
    }
    if (cart != null) {
      data["cart"] = cart?.map((e) => e.toJson()).toList();
    }
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["key"] = key;
    data["quantity"] = quantity;
    data["line_subtotal"] = lineSubtotal;
    data["line_subtotal_tax"] = lineSubtotalTax;
    data["line_total"] = lineTotal;
    data["line_tax"] = lineTax;
    if (productDetails != null) {
      data["product_details"] = productDetails?.toJson();
    }
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["product_id"] = productId;
    data["name"] = name;
    data["description"] = description;
    data["short_description"] = shortDescription;
    data["stock_quantity"] = stockQuantity;
    if (images != null) {
      data["images"] = images?.map((e) => e.toJson()).toList();
    }
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["src"] = src;
    data["alt"] = alt;
    return data;
  }
}

class CartTotals {
  String? subtotal;
  dynamic subtotalTax;
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

    subtotalTax = json["subtotal_tax"];

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["subtotal"] = subtotal;
    data["subtotal_tax"] = subtotalTax;
    data["shipping_total"] = shippingTotal;
    data["shipping_tax"] = shippingTax;
    data["discount_total"] = discountTotal;
    data["discount_tax"] = discountTax;
    data["cart_contents_total"] = cartContentsTotal;
    data["cart_contents_tax"] = cartContentsTax;
    data["total"] = total;
    data["total_tax"] = totalTax;
    return data;
  }
}
