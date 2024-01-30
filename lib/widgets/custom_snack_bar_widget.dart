import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class CustomSnackBarWidget {
  final String snackBarMessage;
  final AnimatedSnackBarType snackBarType;

  CustomSnackBarWidget._({required this.snackBarMessage, required this.snackBarType});
  
  static void notice(BuildContext context, String snackBarMessage) {
    AnimatedSnackBar.material(snackBarMessage,
            type: AnimatedSnackBarType.warning,
            duration: const Duration(seconds: 5))
        .show(context);
  }

  static void facts(BuildContext context, String snackBarMessage) {
    AnimatedSnackBar.material(snackBarMessage,
            type: AnimatedSnackBarType.info,
            duration: const Duration(seconds: 5))
        .show(context);
  }
  static void problem(BuildContext context, String snackBarMessage) {
    AnimatedSnackBar.material(snackBarMessage,
            type: AnimatedSnackBarType.error,
            duration: const Duration(seconds: 5))
        .show(context);
  }

  static void victory(BuildContext context, String snackBarMessage) {
    AnimatedSnackBar.material(snackBarMessage,
            type: AnimatedSnackBarType.success,
            duration: const Duration(seconds: 5))
        .show(context);
  }
}
