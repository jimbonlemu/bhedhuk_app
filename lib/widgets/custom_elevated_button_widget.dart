import 'package:bhedhuk_app/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  final String buttonLabel;
  final void Function()? onPressed;
  final bool isLoading;
  const CustomElevatedButtonWidget({
    super.key,
    required this.buttonLabel,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white), //
            )
          : Text(
              buttonLabel,
              style: bhedhukTextTheme.titleLarge?.copyWith(color: blackColor),
            ),
    );
  }
}