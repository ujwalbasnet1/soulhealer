class LoginResponseModel {
  String message;
  String token;
  UserResponseModel user;

  LoginResponseModel({this.message, this.token, this.user});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new UserResponseModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

enum UserType { HERO, USER }

class UserResponseModel {
  String name;
  String email;
  String type;
  String id;
  int iat;

  UserType get userType => ((type?.toLowerCase() ?? "").compareTo("hero") == 0)
      ? UserType.HERO
      : UserType.USER;

  UserResponseModel({this.name, this.email, this.type, this.id, this.iat});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    type = json['type'];
    id = json['id'];
    iat = json['iat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['type'] = this.type;
    data['id'] = this.id;
    data['iat'] = this.iat;
    return data;
  }
}
