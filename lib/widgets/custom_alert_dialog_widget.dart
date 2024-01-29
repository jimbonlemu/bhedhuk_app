import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Are you sure?',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'Do you want to exit the app?',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _styledElevatedButton(context, false, 'No'),
            _styledElevatedButton(context, true, 'Yes')
          ],
        ),
      ],
    );
  }

  Widget _styledElevatedButton(
      BuildContext context, bool willPop, String text) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pop(willPop),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
