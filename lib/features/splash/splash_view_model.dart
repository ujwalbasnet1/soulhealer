import 'package:soulhealer/common/base_view_model.dart';
import 'package:soulhealer/common/user_data_service.dart';
import 'package:soulhealer/core/navigation/navigation_service.dart';
import 'package:soulhealer/core/navigation/routes.gr.dart';
import 'package:soulhealer/core/push_notification/push_notification_service.dart';
import 'package:soulhealer/data_sources/auth/models/login_response.dart';
import 'package:soulhealer/di/injection.dart';
import 'package:soulhealer/features/message/hero/message_hero_manager.dart';
import 'package:soulhealer/features/message/user/message_user_manager.dart';

import '../onboarding.dart';

class SplashViewModel extends BaseViewModel {
  final NavigationService _navigationService = injection<NavigationService>();
  final PushNotificationService _notificationService =
      injection<PushNotificationService>();

  Future initialize() async {
    UserDataService().retrieve();

    bool _onboardingShown = UserDataService().onboardingSeen ?? false;
    
    if (!_onboardingShown) {
      UserDataService().saveOnboarding();
      await Future.delayed(Duration(milliseconds: 1200));
      _navigationService.navigate(OnboardingView(), clearStack: true);
    } else {
      if (UserDataService().isLoggedIn) {
        await _notificationService.init();
        await _notificationService.subscribe(UserDataService().user.id);

        if (UserDataService().user.userType == UserType.USER) {
          MessageUserManager().init();
        } else {
          await _notificationService.subscribe("hero");
          MessageHeroManager().init();
        }

        await Future.delayed(Duration(milliseconds: 1200));

        _navigationService.navigateToRoute(Routes.homeRoute, clearStack: true);
      } else {
        await Future.delayed(Duration(milliseconds: 1200));
        _navigationService.navigateToRoute(Routes.loginRoute, clearStack: true);
      }
    }
  }
}
