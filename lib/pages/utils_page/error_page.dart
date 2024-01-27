import 'package:bhedhuk_app/utils/styles.dart';
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
            "Hi i'm sorry..",
            style: bhedhukTextTheme.displaySmall,
          ),
          Center(
            child: Text(
              'Something Went Wrong!',
              style: bhedhukTextTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
