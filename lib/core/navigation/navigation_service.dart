import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() {
    return _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateToRoute(
    String routeName, {
    dynamic arguments,
    bool clearStack = false,
  }) {
    return _navigationKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      (_) => !clearStack,
      arguments: arguments,
    );
  }

  Future<dynamic> navigate(
    Widget widget, {
    bool clearStack = false,
  }) {
    return _navigationKey.currentState.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => widget),
      (_) => !clearStack,
    );
  }
}
