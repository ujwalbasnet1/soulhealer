// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:soulhealer/features/message/hero/chat/chat_hero_view_model.dart';
import 'package:soulhealer/di/third_party_module.dart';
import 'package:dio/dio.dart';
import 'package:soulhealer/data_sources/message/message_data_source.dart';
import 'package:soulhealer/features/message/hero/message_hero_view_model.dart';
import 'package:soulhealer/features/message/user/message_user_view_model.dart';
import 'package:soulhealer/core/navigation/navigation_service.dart';
import 'package:soulhealer/core/push_notification/push_notification_service.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:soulhealer/data_sources/auth/auth_data_source.dart';
import 'package:soulhealer/repositories/auth_repo.dart';
import 'package:soulhealer/repositories/message_repo.dart';
import 'package:soulhealer/data_sources/socket/socket_source.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyModules = _$ThirdPartyModules();
  g.registerFactory<ChatHeroViewModel>(() => ChatHeroViewModel());
  g.registerLazySingleton<Dio>(() => thirdPartyModules.dio);
  g.registerFactory<MessageDataSource>(() => MessageDataSource(g<Dio>()));
  g.registerFactory<MessageHeroViewModel>(() => MessageHeroViewModel());
  g.registerFactory<MessageUserViewModel>(() => MessageUserViewModel());
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyModules.navigationService);
  g.registerLazySingleton<PushNotificationService>(
      () => thirdPartyModules.pushNotificationService);
  g.registerLazySingleton<SocketIO>(() => thirdPartyModules.socketIO);
  g.registerFactory<AuthDataSource>(() => AuthDataSource(g<Dio>()));
  g.registerFactory<IAuthRepo>(() => AuthRepo(g<AuthDataSource>()));
  g.registerFactory<IMessageRepo>(() => MessageRepo(g<MessageDataSource>()));
  g.registerFactory<ISocketService>(() => SocketService(g<SocketIO>()));
}

class _$ThirdPartyModules extends ThirdPartyModules {
  @override
  NavigationService get navigationService => NavigationService();
  @override
  PushNotificationService get pushNotificationService =>
      PushNotificationService();
}
