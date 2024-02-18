import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigate {
  static me({required String destination}) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
      destination,
      (Route<dynamic> route) => false,
    );
  }

  static withGift(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static back() => navigatorKey.currentState?.pop();
}
