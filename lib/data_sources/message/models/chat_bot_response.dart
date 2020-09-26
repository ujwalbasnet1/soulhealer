class ChatBotMessageResponseModel {
  String sId;
  // num score;
  String response;

  ChatBotMessageResponseModel({
    this.sId,
    // this.score,
    this.response,
  });

  ChatBotMessageResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    // score = json['score'];
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    // data['score'] = this.score;
    data['response'] = this.response;
    return data;
  }
}
