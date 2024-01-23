import 'package:bhedhuk_app/data/utils/styles.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '404',
            style: bhedhukTextTheme.displaySmall,
          ),
          Center(
            child: Text(
              'Page Not Found',
              style: bhedhukTextTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
