import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:soulhealer/core/models/network_failure.dart';
import 'package:soulhealer/data_sources/message/message_data_source.dart';
import 'package:soulhealer/data_sources/message/models/models.dart';

abstract class IMessageRepo {
  Future<Either<NetworkFailure, MessagesResponseModel>> getUserMessages();
  Future<Either<NetworkFailure, void>> blockVolunteer();

  Future<Either<NetworkFailure, List<MessageItemResponseModel>>> getMessagesOf(
      String conversationId);

  Future<Either<NetworkFailure, List<HeroConversationResponseModel>>>
      getHeroConversations();

  Future<Either<NetworkFailure, List<HeroConversationResponseModel>>>
      getPendingConversations();

  Future<Either<NetworkFailure, AcceptConversationResponseModel>>
      acceptConversation(String conversationId);

  Future<Either<NetworkFailure, List<ChatBotMessageItemModel>>>
      getBotMessages();

  Future<Either<NetworkFailure, ChatBotMessageResponseModel>> sendMessageToBot(
      ChatBotMessageRequestModel message);
}

@Injectable(as: IMessageRepo)
class MessageRepo implements IMessageRepo {
  final MessageDataSource messageDataSource;

  MessageRepo(this.messageDataSource);

  @override
  Future<Either<NetworkFailure, MessagesResponseModel>>
      getUserMessages() async {
    try {
      final result = await messageDataSource.getUserMessages();
      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, AcceptConversationResponseModel>>
      acceptConversation(String conversationId) async {
    try {
      final result = await messageDataSource.acceptConversation(conversationId);
      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, void>> blockVolunteer() async {
    try {
      final result = await messageDataSource.blockVolunteer();
      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, List<HeroConversationResponseModel>>>
      getHeroConversations() async {
    try {
      final result = await messageDataSource.getHeroConversations();
      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, List<MessageItemResponseModel>>> getMessagesOf(
      String conversationId) async {
    try {
      final result = await messageDataSource.getMessagesOf(conversationId);
      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, List<HeroConversationResponseModel>>>
      getPendingConversations() async {
    try {
      final result = await messageDataSource.getPendingConversations();
      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, List<ChatBotMessageItemModel>>>
      getBotMessages() async {
    try {
      final result = await messageDataSource.getBotMessages();
      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, ChatBotMessageResponseModel>> sendMessageToBot(
      ChatBotMessageRequestModel message) async {
    try {
      final result = await messageDataSource.sendMessageToBot(message);
      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }
}
