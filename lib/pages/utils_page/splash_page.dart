import 'dart:async';
import 'package:flutter/material.dart';
import 'navbar_page.dart';
import '../../utils/images.dart';
import '../../utils/navigation_service.dart';

class SplashPage extends StatefulWidget {
  static const route = '/splash_page';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    splashScreenTransition();
  }

  splashScreenTransition() async {
    var duration = const Duration(seconds: 3);
    Timer(duration, () async {
      setState(() {
        _opacity = 1;
      });
      await Future.delayed(const Duration(seconds: 2));
      Navigate.me(destination: NavBarPage.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(40),
                  child: Image.asset(Images.appLogo))
            ],
          ),
        ),
      ),
    );
  }
}
