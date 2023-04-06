import 'package:flutter/material.dart';
import 'package:my_app/core/fade_page_route.dart';
import 'package:my_app/ui/screens/select_photo/select_photo.dart';
import 'package:my_app/ui/screens/home/home.dart';

enum Routes { splash, home, select_photo }

class _Paths {
  static const String splash = '/';
  static const String home = '/home';
  static const String select_photo = '/select_photo';

  static const Map<Routes, String> _pathMap = {
    Routes.splash: _Paths.splash,
    Routes.home: _Paths.home,
    Routes.select_photo: _Paths.select_photo,
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.select_photo:
        return FadeRoute(page: const SelectPhotoScreen());
      default:
        return FadeRoute(page: const HomeScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
