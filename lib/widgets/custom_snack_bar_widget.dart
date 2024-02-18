import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class CustomSnackBarWidget {
  final String snackBarMessage;
  final AnimatedSnackBarType snackBarType;

  CustomSnackBarWidget._(
      {required this.snackBarMessage, required this.snackBarType});

  static void notice(BuildContext context, String snackBarMessage,
      {int durationInSeconds = 3}) {
    AnimatedSnackBar.material(snackBarMessage,
            type: AnimatedSnackBarType.warning,
            duration: Duration(seconds: durationInSeconds))
        .show(context);
  }

  static void facts(BuildContext context, String snackBarMessage,
      {int durationInSeconds = 3}) {
    AnimatedSnackBar.material(snackBarMessage,
            type: AnimatedSnackBarType.info,
            duration: Duration(seconds: durationInSeconds))
        .show(context);
  }

  static void problem(BuildContext context, String snackBarMessage,
      {int durationInSeconds = 3}) {
    AnimatedSnackBar.material(snackBarMessage,
            type: AnimatedSnackBarType.error,
            duration: Duration(seconds: durationInSeconds))
        .show(context);
  }

  static void victory(BuildContext context, String snackBarMessage,
      {int durationInSeconds = 3}) {
    AnimatedSnackBar.material(snackBarMessage,
            type: AnimatedSnackBarType.success,
            duration: Duration(seconds: durationInSeconds))
        .show(context);
  }
}
