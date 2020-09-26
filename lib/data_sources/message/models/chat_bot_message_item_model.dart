class ChatBotMessageItemModel {
  String sId;
  String sender;
  String message;

  ChatBotMessageItemModel({this.sId, this.sender, this.message});

  ChatBotMessageItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sender = json['sender'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['sender'] = this.sender;
    data['message'] = this.message;
    return data;
  }
}