class AddressResponseModel {
  String? status;
  Message? message;
  String? errorMessage;

  AddressResponseModel({this.status, this.message});

  AddressResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["message"] is Map) {
      message =
          json["message"] == null ? null : Message.fromJson(json["message"]);
    } else if (json["message"] is String) {
      status = json["status"];
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
  String? firstName;
  String? lastName;
  String? country;
  String? city;
  String? postcode;
  String? address1;
  String? address2;
  String? phone;
  String? email;
  String? nationalId;
  String? crNumber;
  String? vatNumber;
  String? whatsappNumber;

  Message(
      {this.firstName,
      this.lastName,
      this.country,
      this.city,
      this.postcode,
      this.address1,
      this.address2,
      this.phone,
      this.email,
      this.nationalId,
      this.crNumber,
      this.vatNumber,
      this.whatsappNumber});

  Message.fromJson(Map<String, dynamic> json) {
    if (json["first_name"] is String) {
      firstName = json["first_name"];
    }
    if (json["last_name"] is String) {
      lastName = json["last_name"];
    }
    if (json["country"] is String) {
      country = json["country"];
    }
    if (json["city"] is String) {
      city = json["city"];
    }
    if (json["postcode"] is String) {
      postcode = json["postcode"];
    }
    if (json["address_1"] is String) {
      address1 = json["address_1"];
    }
    if (json["address_2"] is String) {
      address2 = json["address_2"];
    }
    if (json["phone"] is String) {
      phone = json["phone"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["national_id"] is String) {
      nationalId = json["national_id"];
    }
    if (json["cr_number"] is String) {
      crNumber = json["cr_number"];
    }
    if (json["vat_number"] is String) {
      vatNumber = json["vat_number"];
    }
    if (json["whatsapp_number"] is String) {
      whatsappNumber = json["whatsapp_number"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["country"] = country;
    _data["city"] = city;
    _data["postcode"] = postcode;
    _data["address_1"] = address1;
    _data["address_2"] = address2;
    _data["phone"] = phone;
    _data["email"] = email;
    _data["national_id"] = nationalId;
    _data["cr_number"] = crNumber;
    _data["vat_number"] = vatNumber;
    _data["whatsapp_number"] = whatsappNumber;
    return _data;
  }
}
