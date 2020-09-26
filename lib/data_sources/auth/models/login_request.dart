class LoginRequestModel {
  String gender;
  // ENUM "Male|Female|Hidden"

  LoginRequestModel({this.gender});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    return data;
  }
}
