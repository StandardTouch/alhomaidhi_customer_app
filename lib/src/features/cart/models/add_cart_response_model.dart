class AddCartResponseModel {
  String? status;
  String? message;
  String? errorMessage;

  AddCartResponseModel({
    this.status,
    this.message,
    this.errorMessage,
  });

  AddCartResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }

    if (json["message"] is String && json["status"] != "APP00") {
      errorMessage = json["message"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["message"] = message;
    return data;
  }
}
