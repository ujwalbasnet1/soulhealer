class SocketRequestModel {
  String conversation;
  String message;

  SocketRequestModel({this.conversation, this.message});

  SocketRequestModel.fromJson(Map<String, dynamic> json) {
    conversation = json['conversation'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conversation'] = this.conversation;
    data['message'] = this.message;
    return data;
  }
}
