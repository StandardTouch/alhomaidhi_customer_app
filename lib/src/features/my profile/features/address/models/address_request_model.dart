class AddressRequestModel {
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
  String? whatsAppNumber;
  bool isBtnDisable;

  AddressRequestModel(
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
      this.whatsAppNumber,
      this.isBtnDisable = false});

  AddressRequestModel copyWith(
      {String? firstName,
      String? lastName,
      String? country,
      String? city,
      String? postcode,
      String? address1,
      String? address2,
      String? phone,
      String? email,
      String? nationalId,
      String? crNumber,
      String? vatNumber,
      String? whatsAppNumber,
      bool? isBtnDisable}) {
    return AddressRequestModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      country: country ?? this.country,
      city: city ?? this.city,
      postcode: postcode ?? this.postcode,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      nationalId: nationalId ?? this.nationalId,
      crNumber: crNumber ?? this.crNumber,
      vatNumber: vatNumber ?? this.vatNumber,
      whatsAppNumber: whatsAppNumber ?? this.whatsAppNumber,
      isBtnDisable: isBtnDisable ?? false,
    );
  }
}

class AddressRequestResponseModel {
  String? status;
  String? message;

  AddressRequestResponseModel({this.status, this.message});

  factory AddressRequestResponseModel.fromJson(Map<String, dynamic> json) {
    return AddressRequestResponseModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };
}
