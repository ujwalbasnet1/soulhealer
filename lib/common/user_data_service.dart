import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:soulhealer/core/cache/local_cache_service.dart';
import 'package:soulhealer/core/logger/log.dart';
import 'package:soulhealer/data_sources/auth/models/login_response.dart';

class UserDataService {
  final String _tokenKEY = "TOKEN";
  final String _onboardingKEY = "ONBOARD";
  final String _userKEY = "USER";

  Log log = Log("UserDataService");

  UserDataService._();

  factory UserDataService() {
    return _instance;
  }
  static final _instance = UserDataService._();

  String get chatId {
    String _id = JwtDecoder.decode(_token)["id"];
    // log.d(_id);
    return _id;
  }

  bool _onboardingSeen = false;
  bool get onboardingSeen => _onboardingSeen;

  String _token;
  String get token {
    // log.d("Token ${this._token}");
    return _token;
  }

  UserResponseModel _user;
  UserResponseModel get user {
    log.d("Token ${this._token}");
    return _user;
  }

  bool get isLoggedIn => token != null && user != null;

  saveToken(String t) {
    if (t != null) {
      // TODO
      _token = t;
      // =
      // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiT3NzaWUiLCJlbWFpbCI6Ik9zc2llMDE2M0Bzb3VsaGVhbGVyLmFwcCIsInR5cGUiOiJISURERU4iLCJpZCI6IjVmNTA2MTA4MmYwZGQyMjJkNmQ2Mjk2ZiIsImlhdCI6MTU5OTEwMzI0MDM4MH0.27tMDhDZFVBKkRj_wFKAM6LudjCi1jKl0pmO4hBo_JU";

      LocalCacheService.store<String>(_tokenKEY, _token);

      log.s("Token Cached Locally");
    } else {
      throw Exception("Token cannot be null");
    }
  }

  saveOnboarding() {
    LocalCacheService.store<bool>(_onboardingKEY, true);
  }

  saveUser(UserResponseModel u) {
    if (u != null) {
      _user = u;
      final String rawUser = jsonEncode(_user.toJson());
      LocalCacheService.store<String>(_userKEY, rawUser);

      log.s("User Cached Locally");
    } else {
      throw Exception("User cannot be null");
    }
  }

  retrieve() {
    // TODO
    _onboardingSeen = LocalCacheService.retrieve<bool>(_onboardingKEY);
    _token = LocalCacheService.retrieve<String>(_tokenKEY);
    // =
    // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiT3NzaWUiLCJlbWFpbCI6Ik9zc2llMDE2M0Bzb3VsaGVhbGVyLmFwcCIsInR5cGUiOiJISURERU4iLCJpZCI6IjVmNTA2MTA4MmYwZGQyMjJkNmQ2Mjk2ZiIsImlhdCI6MTU5OTEwMzI0MDM4MH0.27tMDhDZFVBKkRj_wFKAM6LudjCi1jKl0pmO4hBo_JU";
    final String rawUser = LocalCacheService.retrieve<String>(_userKEY);

    if (rawUser != null)
      _user = UserResponseModel.fromJson(jsonDecode(rawUser));

    log.s("User Detail Retrieved from Cache");
  }

  clear() {
    _token = null;

    LocalCacheService.remove(_tokenKEY);

    log.s("User Detail Cleared from Cache");
  }
}
