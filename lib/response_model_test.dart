
class ResponseModelTest {
  Message? message;
  String? status;

  ResponseModelTest({this.message, this.status});

  ResponseModelTest.fromJson(Map<String, dynamic> json) {
    if(json["message"] is Map) {
      message = json["message"] == null ? null : Message.fromJson(json["message"]);
    }
    if(json["status"] is String) {
      status = json["status"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(message != null) {
      _data["message"] = message?.toJson();
    }
    _data["status"] = status;
    return _data;
  }
}

class Message {
  String? token;
  String? userId;
  String? username;
  String? useremail;
  String? mobileno;
  String? arabicFullName;

  Message({this.token, this.userId, this.username, this.useremail, this.mobileno, this.arabicFullName});

  Message.fromJson(Map<String, dynamic> json) {
    if(json["token"] is String) {
      token = json["token"];
    }
    if(json["user_id"] is String) {
      userId = json["user_id"];
    }
    if(json["username"] is String) {
      username = json["username"];
    }
    if(json["useremail"] is String) {
      useremail = json["useremail"];
    }
    if(json["mobileno"] is String) {
      mobileno = json["mobileno"];
    }
    if(json["arabic_full_name"] is String) {
      arabicFullName = json["arabic_full_name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["token"] = token;
    _data["user_id"] = userId;
    _data["username"] = username;
    _data["useremail"] = useremail;
    _data["mobileno"] = mobileno;
    _data["arabic_full_name"] = arabicFullName;
    return _data;
  }
}