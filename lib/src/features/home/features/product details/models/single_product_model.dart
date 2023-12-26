class SingleProductModel {
  String? status;
  Message? message;
  String? errorMessage;

  SingleProductModel({
    this.status,
    this.message,
    this.errorMessage,
  });

  SingleProductModel.fromJson(Map<String, dynamic> json) {
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
  ProductDetails? productDetails;
  List<Images>? images;
  List<Brands>? brands;
  List<int>? relatedProductIds;

  Message(
      {this.productDetails, this.images, this.brands, this.relatedProductIds});

  Message.fromJson(Map<String, dynamic> json) {
    if (json["product_details"] is Map) {
      productDetails = json["product_details"] == null
          ? null
          : ProductDetails.fromJson(json["product_details"]);
    }
    if (json["images"] is List) {
      images = json["images"] == null
          ? null
          : (json["images"] as List).map((e) => Images.fromJson(e)).toList();
    }
    if (json["brands"] is List) {
      brands = json["brands"] == null
          ? null
          : (json["brands"] as List).map((e) => Brands.fromJson(e)).toList();
    }
    if (json["related_product_ids"] is List) {
      relatedProductIds = json["related_product_ids"] == null
          ? null
          : List<int>.from(json["related_product_ids"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (productDetails != null) {
      _data["product_details"] = productDetails?.toJson();
    }
    if (images != null) {
      _data["images"] = images?.map((e) => e.toJson()).toList();
    }
    if (brands != null) {
      _data["brands"] = brands?.map((e) => e.toJson()).toList();
    }
    if (relatedProductIds != null) {
      _data["related_product_ids"] = relatedProductIds;
    }
    return _data;
  }
}

class Brands {
  int? id;
  String? name;
  String? slug;

  Brands({this.id, this.name, this.slug});

  Brands.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["slug"] is String) {
      slug = json["slug"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["slug"] = slug;
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

class ProductDetails {
  int? productId;
  String? name;
  String? slug;
  String? dateCreated;
  String? dateModified;
  bool? featured;
  String? catalogVisibility;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  String? discountPercentage;
  bool? onSale;
  int? totalSales;
  int? ratingCount;
  String? stockStatus;
  int? stockQuantity;

  ProductDetails(
      {this.productId,
      this.name,
      this.slug,
      this.dateCreated,
      this.dateModified,
      this.featured,
      this.catalogVisibility,
      this.description,
      this.shortDescription,
      this.sku,
      this.price,
      this.regularPrice,
      this.salePrice,
      this.discountPercentage,
      this.onSale,
      this.totalSales,
      this.ratingCount,
      this.stockStatus,
      this.stockQuantity});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    if (json["product_id"] is int) {
      productId = json["product_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["slug"] is String) {
      slug = json["slug"];
    }
    if (json["date_created"] is String) {
      dateCreated = json["date_created"];
    }
    if (json["date_modified"] is String) {
      dateModified = json["date_modified"];
    }
    if (json["featured"] is bool) {
      featured = json["featured"];
    }
    if (json["catalog_visibility"] is String) {
      catalogVisibility = json["catalog_visibility"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["short_description"] is String) {
      shortDescription = json["short_description"];
    }
    if (json["sku"] is String) {
      sku = json["sku"];
    }
    if (json["price"] is String) {
      price = json["price"];
    }
    if (json["regular_price"] is String) {
      regularPrice = json["regular_price"];
    }
    if (json["sale_price"] is String) {
      salePrice = json["sale_price"];
    }
    if (json["discount_percentage"] is String) {
      discountPercentage = json["discount_percentage"];
    }
    if (json["on_sale"] is bool) {
      onSale = json["on_sale"];
    }
    if (json["total_sales"] is int) {
      totalSales = json["total_sales"];
    }
    if (json["rating_count"] is int) {
      ratingCount = json["rating_count"];
    }
    if (json["stock_status"] is String) {
      stockStatus = json["stock_status"];
    }
    if (json["stock_quantity"] is int) {
      stockQuantity = json["stock_quantity"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["product_id"] = productId;
    _data["name"] = name;
    _data["slug"] = slug;
    _data["date_created"] = dateCreated;
    _data["date_modified"] = dateModified;
    _data["featured"] = featured;
    _data["catalog_visibility"] = catalogVisibility;
    _data["description"] = description;
    _data["short_description"] = shortDescription;
    _data["sku"] = sku;
    _data["price"] = price;
    _data["regular_price"] = regularPrice;
    _data["sale_price"] = salePrice;
    _data["discount_percentage"] = discountPercentage;
    _data["on_sale"] = onSale;
    _data["total_sales"] = totalSales;
    _data["rating_count"] = ratingCount;
    _data["stock_status"] = stockStatus;
    _data["stock_quantity"] = stockQuantity;
    return _data;
  }
}
