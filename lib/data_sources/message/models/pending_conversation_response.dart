class HeroConversationResponseModel {
  String sId;
  bool isPending;
  int messageCount;
  UserResponseModel user;
  String recentMessage;

  HeroConversationResponseModel(
      {this.sId,
      this.isPending,
      this.messageCount,
      this.user,
      this.recentMessage});

  HeroConversationResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isPending = json['is_pending'];
    messageCount = json['message_count'];
    user = json['user'] != null ? new UserResponseModel.fromJson(json['user']) : null;
    recentMessage = json['recent_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['is_pending'] = this.isPending;
    data['message_count'] = this.messageCount;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['recent_message'] = this.recentMessage;
    return data;
  }
}

class UserResponseModel {
  String sId;
  String name;
  String email;

  UserResponseModel({this.sId, this.name, this.email});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}