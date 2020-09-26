import 'dart:async';

import 'package:soulhealer/common/base_view_model.dart';
import 'package:soulhealer/core/logger/log.dart';
import 'package:soulhealer/data_sources/message/models/models.dart';
import 'package:soulhealer/di/injection.dart';
import 'package:soulhealer/repositories/message_repo.dart';

class UserBotViewModel extends BaseViewModel {
  Log log = Log("UserBotViewModel");

  final IMessageRepo _messageRepo = injection<IMessageRepo>();

  List<ChatBotMessageItemModel> _messages;
  List<ChatBotMessageItemModel> get messages => _messages.reversed.toList();

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  Future getMessages({bool refresh = false}) async {
    if (refresh) {
      update(() => _refreshing = true);
    } else {
      setLoading(true);
    }
    clearFailure();
    final result = await _messageRepo.getBotMessages();

    result.fold(
      (NetworkFailure e) => setFailure(e.message),
      (List<ChatBotMessageItemModel> response) {
        update(() {
          _messages = response;
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

  List<String> _sendingIds = [];
  List<String> get sendingIds => _sendingIds;

  List<String> _errorIds = [];
  List<String> get errorIds => _errorIds;

  void sendMessage(String text) async {
    if (text == null || text.trim().isEmpty) return;

    final createdAt = DateTime.now();
    String _generatedId = createdAt.millisecondsSinceEpoch.toString();

    update(() {
      _sendingIds.add(_generatedId);

      _messages.add(ChatBotMessageItemModel(
        sId: _generatedId,
        sender: "USER",
        message: text.trim(),
      ));
    });

    final result = await _messageRepo
        .sendMessageToBot(ChatBotMessageRequestModel(message: text.trim()));

    result.fold(
      (NetworkFailure e) {
        update(() => _errorIds.add(_generatedId));
        KToast.e(e.message);
      },
      (ChatBotMessageResponseModel response) {
        update(() {
          _messages.add(ChatBotMessageItemModel(
            sId: response.sId,
            sender: "BOT",
            message: response.response,
          ));

          _sendingIds.remove(_generatedId);
        });
      },
    );
  }
}
