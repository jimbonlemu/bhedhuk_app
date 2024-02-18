import 'package:flutter/material.dart';
import '../utils/styles.dart';

class IconTitleWidget extends StatelessWidget {
  final IconData icon;
  final String? text;
  const IconTitleWidget({
    super.key,
    required this.icon,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 50,
        ),
        Text(
          text ?? "",
          style: feedMeTextTheme.headlineSmall,
        ),
      ],
    );
  }
}
