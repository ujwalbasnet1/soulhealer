import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';
import 'package:soulhealer/core/models/network_failure.dart';
import 'package:soulhealer/data_sources/auth/auth_data_source.dart';
import 'package:soulhealer/data_sources/auth/models/models.dart';

abstract class IAuthRepo {
  Future<Either<NetworkFailure, LoginResponseModel>> loginHidden(
      LoginRequestModel request);

  Future<Either<NetworkFailure, LoginResponseModel>> googleLogin(
      SocialLoginRequestModel request);
}

@Injectable(as: IAuthRepo)
class AuthRepo implements IAuthRepo {
  final AuthDataSource authDataSource;

  AuthRepo(this.authDataSource);

  @override
  Future<Either<NetworkFailure, LoginResponseModel>> loginHidden(
      LoginRequestModel request) async {
    try {
      final result = await authDataSource.loginHidden(request);
      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, LoginResponseModel>> googleLogin(
      SocialLoginRequestModel request) async {
    try {
      final result = await authDataSource.googleLogin(request);
      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }
}
