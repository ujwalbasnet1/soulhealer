import 'package:dio/dio.dart';

class NetworkFailure extends DioError {
  int _code;
  String _message;

  int get code => _code;
  String get message => _message;

  NetworkFailure({int code,  String message})
      : _code = code,
        _message = message;

  @override
  String toString() {
    return "Failure: Code: $code, Message $message";
  }
}
