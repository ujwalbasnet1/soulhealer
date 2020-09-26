import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:soulhealer/common/base_view_model.dart';
import 'package:soulhealer/common/user_data_service.dart';
import 'package:soulhealer/core/logger/log.dart';
import 'package:soulhealer/core/navigation/navigation_service.dart';
import 'package:soulhealer/data_sources/message/models/messages_response.dart';
import 'package:soulhealer/data_sources/message/models/models.dart';
import 'package:soulhealer/data_sources/socket/models/models.dart';
import 'package:soulhealer/data_sources/socket/socket_source.dart';
import 'package:soulhealer/di/injection.dart';
import 'package:soulhealer/repositories/message_repo.dart';

import '../message_hero_manager.dart';

@injectable
class ChatHeroViewModel extends BaseViewModel {
  Log log = Log("ChatHeroViewModel");

  final MessageHeroManager _messageStateManager = MessageHeroManager();
  final ISocketService _socketService = injection<ISocketService>();

  StreamSubscription<bool> _newMessageSubscription;

  List<MessageItemResponseModel> get reverseMessages =>
      _messageStateManager.messages.reversed.toList();

  init(HeroConversationResponseModel currentChat) {
    _messageStateManager.setCurrentlyChatting(currentChat);

    _newMessageSubscription =
        _messageStateManager.newMessageListener.listen((event) {
          print("HELLo");
      update(() {});
    });

    if (_messagesResponse == null || _messagesResponse.messages == null) {
      getMessages();
    }
  }

  List<String> _sendingIds = [];
  List<String> get sendingIds => _sendingIds;

  List<String> _errorIds = [];
  List<String> get errorIds => _errorIds;

  void sendMessage(String text) {
    if (text == null || text.trim().isEmpty) return;

    final createdAt = DateTime.now();
    String _generatedId = createdAt.millisecondsSinceEpoch.toString();

    _sendingIds.add(_generatedId);
    _messageStateManager.addNewMessageByMe(SocketResponseModel(
      sId: _generatedId,
      sender: UserDataService().chatId,
      message: text.trim(),
      createdAt: createdAt.toIso8601String(),
    ));

    _socketService.sendMessage(
      SocketRequestModel(
        message: text.trim(),
        conversation: _messageStateManager.currentlyChatting.sId,
      ),
      (a) {
        log.d("Message Sending Callback: " + a.toString());
        final rawData = jsonDecode(a);
        if (rawData["success"] != null && rawData["success"] == true) {
          update(() => _sendingIds.remove(_generatedId));
        } else {
          update(() => _errorIds.add(_generatedId));
        }
      },
    );
  }

  @override
  void dispose() {
    _newMessageSubscription?.cancel();
    _messageStateManager.removeCurrentlyChatting();
    super.dispose();
  }

  // GET OLD MESSAGES
  final IMessageRepo _messageRepo = injection<IMessageRepo>();
  final NavigationService _navigationService = injection<NavigationService>();

  MessagesResponseModel _messagesResponse;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  /// get last messages
  Future getMessages({bool refresh = false}) async {
    if (refresh) {
      update(() => _refreshing = true);
    } else {
      setLoading(true);
    }
    clearFailure();
    final result = await _messageRepo
        .getMessagesOf(_messageStateManager.currentlyChatting.sId);

    result.fold(
      (NetworkFailure e) => setFailure(e.message),
      (List<MessageItemResponseModel> response) {
        update(() {
          _messageStateManager.addPreviousMessages(response);
        });

        if (refresh) {
          update(() => _refreshing = false);
        } else {
          setLoading(false);
        }
      },
    );
    if (refresh) {
      update(() => _refreshing = false);
    } else {
      setLoading(false);
    }
  }
}
