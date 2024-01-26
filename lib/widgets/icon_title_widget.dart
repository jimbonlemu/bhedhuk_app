import 'package:bhedhuk_app/data/models/old_data_models/restaurant.dart';
import 'package:bhedhuk_app/utils/styles.dart';
import 'package:flutter/material.dart';

class IconTitleWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconTitleWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 25,
        ),
        Text(
          text,
          style: bhedhukTextTheme.titleLarge,
        ),
      ],
    );
  }
}
