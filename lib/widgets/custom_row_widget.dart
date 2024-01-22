import 'package:flutter/material.dart';

class CustomRowWidget extends StatelessWidget {
  final Widget? child;
  final List<Widget>? children;

  const CustomRowWidget({super.key, this.child, this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (child != null) child!,
        ...children ?? [],
      ],
    );
  }
}
