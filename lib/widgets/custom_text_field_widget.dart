import 'package:flutter/material.dart';
import '../utils/styles.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String? label;
  final TextEditingController? textController;

  const CustomTextFieldWidget({super.key, this.textController, this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: blackColor,
        ),
      ),
      minLines: 1,
      maxLines: 5,
    );
  }
}
