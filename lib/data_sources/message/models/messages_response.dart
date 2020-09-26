class MessagesResponseModel {
  List<MessageItemResponseModel> messages;

  MessagesResponseModel({this.messages});

  MessagesResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = new List<MessageItemResponseModel>();
      json['messages'].forEach((v) {
        messages.add(new MessageItemResponseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() => messages.map((m) => m.toJson().toString() + "\n\n").toList().toString();
}

class ConversationResponseModel {
  String sId;
  bool isPending;
  int messageCount;
  String recentMessage;
  Null hero;

  ConversationResponseModel(
      {this.sId,
      this.isPending,
      this.messageCount,
      this.recentMessage,
      this.hero});

  ConversationResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isPending = json['is_pending'];
    messageCount = json['message_count'];
    recentMessage = json['recent_message'];
    hero = json['hero'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['is_pending'] = this.isPending;
    data['message_count'] = this.messageCount;
    data['recent_message'] = this.recentMessage;
    data['hero'] = this.hero;
    return data;
  }
}

class MessageItemResponseModel {
  String sId;
  SenderResponseModel sender;
  String message;
  String createdAt;
  String type;

  MessageItemResponseModel(
      {this.sId, this.sender, this.message, this.createdAt, this.type});

  MessageItemResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sender = json['sender'] != null
        ? new SenderResponseModel.fromJson(json['sender'])
        : null;
    message = json['message'];
    createdAt = json['created_at'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.sender != null) {
      data['sender'] = this.sender.toJson();
    }
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['type'] = this.type;
    return data;
  }
}

class SenderResponseModel {
  String sId;
  String name;
  String email;

  SenderResponseModel({this.sId, this.name, this.email});

  SenderResponseModel.fromJson(Map<String, dynamic> json) {
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
