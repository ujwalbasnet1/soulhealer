// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:soulhealer/features/splash/splash_view.dart';
import 'package:soulhealer/core/navigation/routes.dart';
import 'package:soulhealer/features/login/login_view.dart';
import 'package:soulhealer/features/home/home_view.dart';
import 'package:soulhealer/features/message/message_view.dart';
import 'package:soulhealer/features/message/hero/chat/chat_hero_view.dart';
import 'package:soulhealer/data_sources/message/models/pending_conversation_response.dart';

abstract class Routes {
  static const splashRoute = '/';
  static const loginRoute = '/login-route';
  static const homeRoute = '/home-route';
  static const messageRoute = '/message-route';
  static const chatHeroRoute = '/chat-hero-route';
  static const all = {
    splashRoute,
    loginRoute,
    homeRoute,
    messageRoute,
    chatHeroRoute,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.splashRoute:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) => SplashView(),
          settings: settings,
          transitionsBuilder: fade,
          transitionDuration: const Duration(milliseconds: 400),
        );
      case Routes.loginRoute:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) => LoginView(),
          settings: settings,
          transitionsBuilder: fade,
          transitionDuration: const Duration(milliseconds: 400),
        );
      case Routes.homeRoute:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) => HomeView(),
          settings: settings,
          transitionsBuilder: fade,
          transitionDuration: const Duration(milliseconds: 400),
        );
      case Routes.messageRoute:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              MessageView(),
          settings: settings,
          transitionsBuilder: slideUp,
          transitionDuration: const Duration(milliseconds: 400),
        );
      case Routes.chatHeroRoute:
        if (hasInvalidArgs<ChatHeroViewArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<ChatHeroViewArguments>(args);
        }
        final typedArgs = args as ChatHeroViewArguments;
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ChatHeroView(key: typedArgs.key, item: typedArgs.item),
          settings: settings,
          transitionsBuilder: fade,
          transitionDuration: const Duration(milliseconds: 400),
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//ChatHeroView arguments holder class
class ChatHeroViewArguments {
  final Key key;
  final HeroConversationResponseModel item;
  ChatHeroViewArguments({this.key, @required this.item});
}
