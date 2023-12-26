class DeleteProfileRequestModel {
  bool isBtnDisable;
  DeleteProfileRequestModel({this.isBtnDisable = false});
  DeleteProfileRequestModel copyWith({bool? isBtnDisable}) {
    return DeleteProfileRequestModel(isBtnDisable: isBtnDisable ?? false);
  }
}

class DeleteProfileRequestResponseModel {
  String? status;
  String? message;

  DeleteProfileRequestResponseModel({this.status, this.message});

  factory DeleteProfileRequestResponseModel.fromJson(
      Map<String, dynamic> json) {
    return DeleteProfileRequestResponseModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };
}
