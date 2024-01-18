class MyOrdersListModel {
  String? status;
  List<Message>? message;
  String? errorMessage;

  MyOrdersListModel({this.status, this.message});

  MyOrdersListModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["message"] is List) {
      message = json["message"] == null
          ? null
          : (json["message"] as List).map((e) => Message.fromJson(e)).toList();
    } else if (json["message"] is String) {
      errorMessage = json["message"];
      status = json["status"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    if (message != null) {
      data["message"] = message?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Message {
  OrderDetails? orderDetails;
  BillingDetails? billingDetails;
  PaymentDetails? paymentDetails;
  List<Items>? items;

  Message(
      {this.orderDetails,
      this.billingDetails,
      this.paymentDetails,
      this.items});

  Message.fromJson(Map<String, dynamic> json) {
    if (json["order_details"] is Map) {
      orderDetails = json["order_details"] == null
          ? null
          : OrderDetails.fromJson(json["order_details"]);
    }
    if (json["billing_details"] is Map) {
      billingDetails = json["billing_details"] == null
          ? null
          : BillingDetails.fromJson(json["billing_details"]);
    }
    if (json["payment_details"] is Map) {
      paymentDetails = json["payment_details"] == null
          ? null
          : PaymentDetails.fromJson(json["payment_details"]);
    }
    if (json["items"] is List) {
      items = json["items"] == null
          ? null
          : (json["items"] as List).map((e) => Items.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderDetails != null) {
      data["order_details"] = orderDetails?.toJson();
    }
    if (billingDetails != null) {
      data["billing_details"] = billingDetails?.toJson();
    }
    if (paymentDetails != null) {
      data["payment_details"] = paymentDetails?.toJson();
    }
    if (items != null) {
      data["items"] = items?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? itemName;
  int? productId;
  int? quantity;
  String? subtotal;
  String? subtotalTax;
  String? total;
  String? totalTax;
  String? sku;
  String? image;

  Items(
      {this.itemName,
      this.productId,
      this.quantity,
      this.subtotal,
      this.subtotalTax,
      this.total,
      this.totalTax,
      this.sku,
      this.image});

  Items.fromJson(Map<String, dynamic> json) {
    if (json["item_name"] is String) {
      itemName = json["item_name"];
    }
    if (json["product_id"] is int) {
      productId = json["product_id"];
    }
    if (json["quantity"] is int) {
      quantity = json["quantity"];
    }
    if (json["subtotal"] is String) {
      subtotal = json["subtotal"];
    }
    if (json["subtotal_tax"] is String) {
      subtotalTax = json["subtotal_tax"];
    }
    if (json["total"] is String) {
      total = json["total"];
    }
    if (json["total_tax"] is String) {
      totalTax = json["total_tax"];
    }
    if (json["sku"] is String) {
      sku = json["sku"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["item_name"] = itemName;
    data["product_id"] = productId;
    data["quantity"] = quantity;
    data["subtotal"] = subtotal;
    data["subtotal_tax"] = subtotalTax;
    data["total"] = total;
    data["total_tax"] = totalTax;
    data["sku"] = sku;
    data["image"] = image;
    return data;
  }
}

class PaymentDetails {
  String? paymentMethod;
  String? paymentMethodTitle;
  dynamic datePaid;

  PaymentDetails({this.paymentMethod, this.paymentMethodTitle, this.datePaid});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    if (json["payment_method"] is String) {
      paymentMethod = json["payment_method"];
    }
    if (json["payment_method_title"] is String) {
      paymentMethodTitle = json["payment_method_title"];
    }
    datePaid = json["date_paid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["payment_method"] = paymentMethod;
    data["payment_method_title"] = paymentMethodTitle;
    data["date_paid"] = datePaid;
    return data;
  }
}

class BillingDetails {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? email;
  String? phone;

  BillingDetails(
      {this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.email,
      this.phone});

  BillingDetails.fromJson(Map<String, dynamic> json) {
    if (json["first_name"] is String) {
      firstName = json["first_name"];
    }
    if (json["last_name"] is String) {
      lastName = json["last_name"];
    }
    if (json["company"] is String) {
      company = json["company"];
    }
    if (json["address_1"] is String) {
      address1 = json["address_1"];
    }
    if (json["address_2"] is String) {
      address2 = json["address_2"];
    }
    if (json["city"] is String) {
      city = json["city"];
    }
    if (json["state"] is String) {
      state = json["state"];
    }
    if (json["postcode"] is String) {
      postcode = json["postcode"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["phone"] is String) {
      phone = json["phone"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["first_name"] = firstName;
    data["last_name"] = lastName;
    data["company"] = company;
    data["address_1"] = address1;
    data["address_2"] = address2;
    data["city"] = city;
    data["state"] = state;
    data["postcode"] = postcode;
    data["email"] = email;
    data["phone"] = phone;
    return data;
  }
}

class OrderDetails {
  String? orderId;
  String? orderPlacedDate;
  String? orderDateModified;
  String? orderStatus;
  String? total;
  String? totalTax;
  String? discountTotal;
  String? discountTax;
  String? cartTax;

  OrderDetails(
      {this.orderId,
      this.orderPlacedDate,
      this.orderDateModified,
      this.orderStatus,
      this.total,
      this.totalTax,
      this.discountTotal,
      this.discountTax,
      this.cartTax});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    if (json["order_id"] is String) {
      orderId = json["order_id"];
    }
    if (json["order_placed_date"] is String) {
      orderPlacedDate = json["order_placed_date"];
    }
    if (json["order_date_modified"] is String) {
      orderDateModified = json["order_date_modified"];
    }
    if (json["order_status"] is String) {
      orderStatus = json["order_status"];
    }
    if (json["total"] is String) {
      total = json["total"];
    }
    if (json["total_tax"] is String) {
      totalTax = json["total_tax"];
    }
    if (json["discount_total"] is String) {
      discountTotal = json["discount_total"];
    }
    if (json["discount_tax"] is String) {
      discountTax = json["discount_tax"];
    }
    if (json["cart_tax"] is String) {
      cartTax = json["cart_tax"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["order_id"] = orderId;
    data["order_placed_date"] = orderPlacedDate;
    data["order_date_modified"] = orderDateModified;
    data["order_status"] = orderStatus;
    data["total"] = total;
    data["total_tax"] = totalTax;
    data["discount_total"] = discountTotal;
    data["discount_tax"] = discountTax;
    data["cart_tax"] = cartTax;
    return data;
  }
}
