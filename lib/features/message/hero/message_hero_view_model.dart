import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:soulhealer/common/base_view_model.dart';
import 'package:soulhealer/core/logger/log.dart';
import 'package:soulhealer/core/navigation/navigation_service.dart';
import 'package:soulhealer/core/navigation/routes.gr.dart';
import 'package:soulhealer/data_sources/message/models/models.dart';
import 'package:soulhealer/di/injection.dart';
import 'package:soulhealer/features/message/hero/message_hero_manager.dart';
import 'package:soulhealer/repositories/message_repo.dart';

@injectable
class MessageHeroViewModel extends BaseViewModel {
  Log log = Log("MessageHeroViewModel");

  final MessageHeroManager _messageStateManager = MessageHeroManager();

  int _currentIndex = 0;

  void changeTab(int index) {
    update(() => _currentIndex = index);

    switch (index) {
      case 0:
        if (_messageStateManager?.recentConversations == null) {
          getRecentConversations();
        }
        return;
      case 1:
        if (_pendingConversations == null) {
          getPendingConversations();
        }
        return;
      default:
        getRecentConversations();
    }
  }

  init() {
    getRecentConversations();
  }

  final IMessageRepo _messageRepo = injection<IMessageRepo>();
  final NavigationService _navigationService = injection<NavigationService>();

  bool _loadingRecent = false;
  bool get loadingRecent => _loadingRecent;

  String _recentError;
  String get recentError => _recentError;

  List<HeroConversationResponseModel> get recentConversations =>
      _messageStateManager?.recentConversations;

  Future getRecentConversations({bool refresh = false}) async {
    update(() => _recentError = null);
    if (refresh) {
      setLoading(true);
    } else {
      update(() => _loadingRecent = true);
    }
    clearFailure();
    final result = await _messageRepo.getHeroConversations();

    result.fold(
      (NetworkFailure e) =>
          update(() => _recentError = e.message ?? "Some Error Occured"),
      (List<HeroConversationResponseModel> response) {
        update(() {
          _messageStateManager.addRecentConversations(response);
        });

        if (refresh) {
          setLoading(false);
        } else {
          update(() => _loadingRecent = false);
        }
      },
    );
    if (refresh) {
      setLoading(false);
    } else {
      update(() => _loadingRecent = false);
    }
  }

  bool _loadingPending = false;
  bool get loadingPending => _loadingPending;

  String _pendingError;
  String get pendingError => _pendingError;

  List<HeroConversationResponseModel> _pendingConversations;
  List<HeroConversationResponseModel> get pendingConversations =>
      _pendingConversations;

  Future getPendingConversations({bool refresh = false}) async {
    update(() => _pendingError = null);
    if (refresh) {
      setLoading(true);
    } else {
      update(() => _loadingPending = true);
    }
    clearFailure();
    final result = await _messageRepo.getPendingConversations();

    result.fold(
      (NetworkFailure e) =>
          update(() => _pendingError = e.message ?? "Some Error Occured"),
      (List<HeroConversationResponseModel> response) {
        update(() => _pendingConversations = response);

        if (refresh) {
          setLoading(false);
        } else {
          update(() => _loadingPending = false);
        }
      },
    );
    if (refresh) {
      setLoading(false);
    } else {
      update(() => _loadingPending = false);
    }
  }

  String _accepting;
  String get accepting => _accepting;

  Future acceptConversation(
      HeroConversationResponseModel pendingConversation) async {
    if (pendingConversation == null) return;

    update(() => _accepting = pendingConversation.sId);

    final result =
        await _messageRepo.acceptConversation(pendingConversation.sId);

    result.fold(
      (NetworkFailure e) => KToast.e(e.message ?? "Some Error Occured"),
      (AcceptConversationResponseModel response) {
        KToast.s(response.message ?? "Accepted");
        update(() => _accepting = null);
      },
    );

    update(() => _accepting = null);
  }

  onRecentChatItemPressed(HeroConversationResponseModel model) {
    _navigationService.navigateToRoute(
      Routes.chatHeroRoute,
      arguments: ChatHeroViewArguments(item: model),
    );
  }
}
