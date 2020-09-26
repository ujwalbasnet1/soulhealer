class AcceptConversationResponseModel {
  String message;
  String conversation;

  AcceptConversationResponseModel({this.message, this.conversation});

  AcceptConversationResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    conversation = json['conversation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['conversation'] = this.conversation;
    return data;
  }
}