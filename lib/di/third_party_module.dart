import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:soulhealer/common/http_config.dart';
import 'package:soulhealer/common/user_data_service.dart';
import 'package:soulhealer/core/logger/log.dart';
import 'package:soulhealer/core/models/network_failure.dart';
import 'package:soulhealer/core/navigation/navigation_service.dart';
import 'package:soulhealer/core/push_notification/push_notification_service.dart';
import 'package:soulhealer/data_sources/response_error_model.dart';

@module
abstract class ThirdPartyModules {
  @lazySingleton
  NavigationService get navigationService;

  @lazySingleton
  PushNotificationService get pushNotificationService;

  @lazySingleton
  SocketIO get socketIO {
    return SocketIOManager().createSocketIO(
      HttpConfig.socketBaseURL,
      '/',
      query: "token=${UserDataService().token}",
      socketStatusCallback: (data) {
        Log.debug("Socket Status", data.toString());
      },
    );
  }

  @lazySingleton
  Dio get dio {
    Dio dio = Dio();

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (requestOptions) {
        requestOptions.headers.addAll({
          'Authorization': 'Bearer ${UserDataService()?.token ?? ""}',
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json, text/plain, */*',
        });

        Log.debug("DIO REQUEST ${requestOptions.method}",
            requestOptions.baseUrl + requestOptions.uri.path);

        return requestOptions;
      },
      onResponse: (Response response) {
        return response;
      },
      onError: customDioErrorInterceptor,
    ));
    return dio;
  }
}

customDioErrorInterceptor(DioError error, {String logTitle = ""}) {
  if (error.response != null) {
    // that falls out of the range of 2xx and is also not 304;
    try {
      ResponseErrorModel response = ResponseErrorModel.fromJson(
          (error.response.data is String)
              ? jsonDecode(error.response.data)
              : error.response.data);
      Log.debug("DIO ERROR RESPONSE", error.response.data.toString());
      throw NetworkFailure(message: response.message);
    } catch (e) {
      print(e);
      if (e is NetworkFailure) throw NetworkFailure(message: e.message);
      Log.debug("DIO error $logTitle", "not of Network Failure");
      throw NetworkFailure(message: "Some Error occured");
    }
  } else {
    print(
        "\n\nSomething happened in setting up or sending the DIO request that triggered an Error.\n\n");

    Log.debug("DIO error $logTitle", "resonse is null");
    throw NetworkFailure(
        message:
            "Service is temporary unavailable,\ncheck your network connection.");
  }
}
