import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:soulhealer/features/home/home_view.dart';
import 'package:soulhealer/features/login/login_view.dart';
import 'package:soulhealer/features/message/hero/chat/chat_hero_view.dart';
import 'package:soulhealer/features/message/message_view.dart';
import 'package:soulhealer/features/splash/splash_view.dart';

@CustomAutoRouter(
  transitionsBuilder: fade,
  durationInMilliseconds: 400,
)
class $Router {
  @initial
  SplashView splashRoute;

  LoginView loginRoute;

  HomeView homeRoute;

  @CustomRoute(transitionsBuilder: slideUp, durationInMilliseconds: 400)
  MessageView messageRoute;

  ChatHeroView chatHeroRoute;
}

Widget fade(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) =>
    FadeTransition(
      opacity: animation,
      child: child,
    );

Widget slideUp(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  Animation<Offset> position = Tween<Offset>(
    begin: Offset(0, 1),
    end: Offset(0, 1 - animation.value),
  ).animate(animation);

  return SlideTransition(
    position: position,
    child: child,
  );
}
