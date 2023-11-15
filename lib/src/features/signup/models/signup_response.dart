class SignupResponseModel {
	String? status;
	String? message;

	SignupResponseModel({this.status, this.message});

	factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
		return SignupResponseModel(
			status: json['status'] as String?,
			message: json['message'] as String?,
		);
	}



	Map<String, dynamic> toJson() => {
				'status': status,
				'message': message,
			};
}
