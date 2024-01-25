import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigate {
  static me({required String destination, Object? gift}) {
    return navigatorKey.currentState!.pushReplacementNamed(destination, arguments: gift);
  }
}
