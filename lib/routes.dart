import 'package:flutter/material.dart';
import 'package:sejuta_cita/themes/theme.dart';
import 'package:sejuta_cita/views/pages/home.dart';

enum Routes { home }

class _Paths {
  static const String home = '/home';
  static const Map<Routes, String> _pathMap = {Routes.home: _Paths.home};

  static String of(Routes route) => _pathMap[route];
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.home:
      default:
        return FadeRoute(page: HomeScreen());
    }
  }

  static NavigatorState get state => navigatorKey.currentState;
  static Future replaceWith<T>(Routes route, [T arguments]) =>
      state.pushReplacementNamed(_Paths.of(route), arguments: arguments);
  static Future push<T>(Routes route, [T arguments]) =>
      state.pushNamed(_Paths.of(route), arguments: arguments);
  static void pop() => state.pop();
}
