class SocialLoginRequestModel {
  String gender;
  // ENUM "Male|Female|Hidden"
  String token;

  SocialLoginRequestModel({this.gender, this.token});

  SocialLoginRequestModel.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['token'] = this.token;
    return data;
  }
}
