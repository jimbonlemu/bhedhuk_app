import '../utils/styles.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final String title;
  final List<dynamic> objectToList;

  const MenuWidget({
    super.key,
    required this.title,
    required this.objectToList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: bhedhukTextTheme.titleMedium,
        ),
        Text(
          objectToList.map((object) => '- $object').join('\n'),
          style: bhedhukTextTheme.bodyLarge,
        ),
      ],
    );
  }
}
