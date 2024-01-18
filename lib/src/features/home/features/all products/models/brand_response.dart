class BrandResponse {
  String? status;
  List<Message>? message;
  String? errorMessage;
  String? errorCode;

  BrandResponse({this.status, this.message, this.errorCode, this.errorMessage});

  BrandResponse.fromJson(Map<String, dynamic> json) {
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["message"] is List) {
      message = json["message"] == null
          ? null
          : (json["message"] as List).map((e) => Message.fromJson(e)).toList();
    } else if (json["message"] is String && json["status"] is String) {
      errorCode = json["status"];
      errorMessage = json["message"];
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
  int? id;
  String? name;
  String? img;

  Message({this.id, this.name, this.img});

  Message.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["img"] is String) {
      img = json["img"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["img"] = img;
    return data;
  }
}
