import 'package:soulhealer/common/base_view_model.dart';
import 'package:soulhealer/core/logger/log.dart';

class HomeViewModel extends BaseViewModel {
  Log log = Log("HomeViewModel");

  Future init() async {
    setLoading(true);
    await Future.delayed(Duration(seconds: 2));
    // final result =
    //     await _authRepo.loginHidden(LoginRequestModel(gender: "Hidden"));

    // result.fold(
    //   (NetworkFailure e) => KToast.e(e.message),
    //   (LoginResponseModel response) {
    //     KToast.s("Logged In Successfully");
    //     setLoading(false);

    //     UserDataService().saveToken(response.token);
    //     UserDataService().saveUser(response.user);

    //     Future.delayed(Duration(milliseconds: 200), () {
    //       _navigationService.navigateToRoute(Routes.homeRoute,
    //           clearStack: true);
    //     });
    //   },
    // );
    setLoading(false);
  }
}
