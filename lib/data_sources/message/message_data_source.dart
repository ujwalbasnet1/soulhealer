import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:soulhealer/common/http_config.dart';

import 'models/models.dart';

part 'message_data_source.g.dart';

@injectable
@RestApi(baseUrl: HttpConfig.baseURL)
abstract class MessageDataSource {
  @factoryMethod
  factory MessageDataSource(Dio dio) = _MessageDataSource;

  @GET('/user/message')
  Future<MessagesResponseModel> getUserMessages();

  @POST('/user/block')
  Future<void> blockVolunteer();

  @GET('/hero/message/{conversationId}')
  Future<List<MessageItemResponseModel>> getMessagesOf(
      @Path("conversationId") String conversationId);

  @GET('/hero/conversation')
  Future<List<HeroConversationResponseModel>> getHeroConversations();

  @GET('/hero/conversation_pending')
  Future<List<HeroConversationResponseModel>> getPendingConversations();

  @POST('/hero/conversation_accept/{conversationId}')
  Future<AcceptConversationResponseModel> acceptConversation(
      @Path("conversationId") String conversationId);

  @POST('/user/get_bot_messages')
  Future<List<ChatBotMessageItemModel>> getBotMessages();

  @POST('/user/bot_message')
  Future<ChatBotMessageResponseModel> sendMessageToBot(
      @Body() ChatBotMessageRequestModel message);
}

void main() async {
  // volunteer, user
  final String token =
      // new user
      // Token eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVmNTBkMTU4ZDM5NWFiMWVjYmQwMDdjNiIsIm5hbWUiOiJVandhbCBCYXNuZXQiLCJlbWFpbCI6InVqd2FsYmFzbmV0MUBnbWFpbC5jb20iLCJpbWFnZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hLS9BT2gxNEdqRmc0X2NCWDAzQ1FPOE96TzNmUXNiTFh6RkUtS2d1SFZIVTNiVz1zOTYtYyIsInR5cGUiOiJIRVJPIiwiaWF0IjoxNTk5NTY5NDE1MzY2fQ.airbAoWv2XIdjG4UU7CEZ9HNsd6uw3b6jPaULePsEvM
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVmNGZiZmZlMmYwZGQyMjJkNmQ2Mjk1NSIsIm5hbWUiOiJLaXJhbiBOZXVwYW5lIiwiZW1haWwiOiJ0b2tleXJ1bkBnbWFpbC5jb20iLCJpbWFnZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hLS9BT2gxNEdqYk5PNGhmV014VzExYWdKT0hQYXF0cW1DekdieE9wUU9EYWxncz1zOTYtYyIsInR5cGUiOiJIRVJPIiwiaWF0IjoxNTk5MDYyMDE0NjMyfQ.0XEMeMLDy79KcbxoICqvNu7EddLOt7wazEt7oyz8XmE";
  // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiT3NzaWUiLCJlbWFpbCI6Ik9zc2llMDE2M0Bzb3VsaGVhbGVyLmFwcCIsInR5cGUiOiJISURERU4iLCJpZCI6IjVmNTA2MTA4MmYwZGQyMjJkNmQ2Mjk2ZiIsImlhdCI6MTU5OTEwMzI0MDM4MH0.27tMDhDZFVBKkRj_wFKAM6LudjCi1jKl0pmO4hBo_JU";

  MessageDataSource _client = _MessageDataSource(Dio(
    BaseOptions(headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json, text/plain, */*',
    }),
  ));

  try {
    final response =
        await _client.acceptConversation("5f6ab8a793b0556ce989288a");

    print(response.toJson().toString());
  } on DioError catch (e) {
    print(e.response.data);
  }
}
