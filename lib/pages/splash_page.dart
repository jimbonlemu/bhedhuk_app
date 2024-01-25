import 'dart:async';

import 'package:bhedhuk_app/data/utils/images.dart';
import 'package:bhedhuk_app/pages/navbar_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _opacity = 1;

  @override
  void initState() {
    super.initState();
    splashScreenTransition();
  }

  splashScreenTransition() async {
    var duration = const Duration(seconds: 2);
    Timer(duration, () async {
      setState(() {
        _opacity = 0;
      });
      await Future.delayed(const Duration(seconds: 1));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return const NavBarPage();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1),
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
