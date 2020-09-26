class SocketResponseModel {
  String sId;
  String conversation;
  String sender;
  String message;
  String createdAt;

  SocketResponseModel(
      {this.sId, this.conversation, this.sender, this.message, this.createdAt});

  SocketResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    conversation = json['conversation'];
    sender = json['sender'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['conversation'] = this.conversation;
    data['sender'] = this.sender;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    return data;
  }
}