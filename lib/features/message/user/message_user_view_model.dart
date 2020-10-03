import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:soulhealer/common/base_view_model.dart';
import 'package:soulhealer/common/user_data_service.dart';
import 'package:soulhealer/core/logger/log.dart';
import 'package:soulhealer/core/navigation/navigation_service.dart';
import 'package:soulhealer/data_sources/message/models/messages_response.dart';
import 'package:soulhealer/data_sources/socket/models/models.dart';
import 'package:soulhealer/data_sources/socket/socket_source.dart';
import 'package:soulhealer/di/injection.dart';
import 'package:soulhealer/features/message/user/message_user_manager.dart';
import 'package:soulhealer/repositories/message_repo.dart';

@injectable
class MessageUserViewModel extends BaseViewModel {
  Log log = Log("MessageUserViewModel");

  final MessageUserManager _messageStateManager = MessageUserManager();
  final ISocketService _socketService = injection<ISocketService>();

  StreamSubscription<bool> _newMessageSubscription;

  List<MessageItemResponseModel> get reverseMessages =>
      _messageStateManager.messages.reversed.toList();

  init() {
    _messageStateManager.setCurrentlyChatting();

    _newMessageSubscription =
        _messageStateManager.newMessageListener.listen((event) {
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
    final result = await _messageRepo.getUserMessages();

    result.fold(
      (NetworkFailure e) => setFailure(e.message),
      (MessagesResponseModel response) {
        log.d(response.messages.map((m) => m.message).join());
        update(() {
          _messageStateManager.addPreviousMessages(response.messages);
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

  bool _blocking = false;
  bool get blocking => _blocking;

  blockHero() async {
    update(() => _blocking = true);

    clearFailure();
    final result = await _messageRepo.blockVolunteer();

    result.fold(
      (NetworkFailure e) => setFailure(e.message),
      (_) {
        KToast.s("Blocked Hero.. You will shortly be replied by another hero");

        update(() => _blocking = false);
      },
    );

    update(() => _blocking = false);
  }
}
