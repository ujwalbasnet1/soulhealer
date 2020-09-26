import 'package:google_sign_in/google_sign_in.dart';
import 'package:soulhealer/common/base_view_model.dart';
import 'package:soulhealer/common/user_data_service.dart';
import 'package:soulhealer/core/logger/log.dart';
import 'package:soulhealer/core/navigation/navigation_service.dart';
import 'package:soulhealer/core/navigation/routes.gr.dart';
import 'package:soulhealer/core/push_notification/push_notification_service.dart';
import 'package:soulhealer/data_sources/auth/models/models.dart';
import 'package:soulhealer/di/injection.dart';
import 'package:soulhealer/repositories/auth_repo.dart';

class LoginViewModel extends BaseViewModel {
  Log log = Log("LoginViewModel");

  final IAuthRepo _authRepo = injection<IAuthRepo>();
  final NavigationService _navigationService = injection<NavigationService>();
  final PushNotificationService _notificationService =
      injection<PushNotificationService>();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        "415303719139-j9btmemqhump3netilsucq3grpm9vfa5.apps.googleusercontent.com",
  );

  Future loginHidden() async {
    setLoading(true);
    final result =
        await _authRepo.loginHidden(LoginRequestModel(gender: "Hidden"));

    result.fold(
      (NetworkFailure e) => KToast.e(e.message),
      (LoginResponseModel response) async {
        KToast.s("Logged In Successfully");
        setLoading(false);

        UserDataService().saveToken(response.token);
        UserDataService().saveUser(response.user);

        await _notificationService.init();
        await _notificationService.subscribe(response.user.id);

        Future.delayed(Duration(milliseconds: 200), () {
          _navigationService.navigateToRoute(Routes.homeRoute,
              clearStack: true);
        });
      },
    );
    setLoading(false);
  }

  Future googleLogin() async {
    try {
      _googleSignIn.disconnect();
      GoogleSignInAccount _account = await _googleSignIn.signIn();
      GoogleSignInAuthentication _authentication =
          await _account.authentication;

      setLoading(true);

      final result = await _authRepo.googleLogin(SocialLoginRequestModel(
        gender: "Hidden",
        token: _authentication.idToken,
      ));

      result.fold(
        (NetworkFailure e) => KToast.e(e.message),
        (LoginResponseModel response) async {
          log.d(response.toJson().toString());
          KToast.s("Logged In Successfully");
          setLoading(false);

          UserDataService().saveToken(response.token);
          UserDataService().saveUser(response.user);

          await _notificationService.init();
          await _notificationService.subscribe(response.user.id);

          Future.delayed(Duration(milliseconds: 200), () {
            _navigationService.navigateToRoute(Routes.homeRoute,
                clearStack: true);
          });
        },
      );
      setLoading(false);
    } catch (e) {
      log.d(e.toString());
    }
  }
}
