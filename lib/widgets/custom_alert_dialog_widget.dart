// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:bhedhuk_app/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String purpose;
  void Function()? onPressed;
  CustomAlertDialog({
    super.key,
    required this.purpose,
     this.onPressed,
    // this.pressedAction,
  });

  @override
  Widget build(BuildContext context) {
    switch (purpose) {
      case 'exitAlert':
        return _buildExitAlertDialog(context);
      case 'internetConnectionAlert':
        return _buildNoInternetDialog(context);
      default:
        throw ArgumentError("Invalid Purpose $purpose");
    }
  }

  Widget _buildNoInternetDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Something wrong', textAlign: TextAlign.center),
      icon: const Icon(
        Icons.signal_cellular_connected_no_internet_0_bar_rounded,
        color: blackColor,
        size: 45,
      ),
      content: const Text(
        'Please Check your Internet Connection',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Reconnect',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExitAlertDialog(BuildContext context) {
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
            _styledElevatedButton(
              context: context,
              willPop: false,
              text: 'No',
            ),
            _styledElevatedButton(
              context: context,
              willPop: true,
              text: 'Yes',
            )
          ],
        ),
      ],
    );
  }

  Widget _styledElevatedButton({
    required BuildContext context,
    bool? willPop = false,
    required String text,
  }) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop(willPop);
      },
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
