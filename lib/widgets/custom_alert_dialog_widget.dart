// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:feed_me/utils/styles.dart';
import 'package:feed_me/widgets/custom_elevated_button_widget.dart';
import 'package:feed_me/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String purpose;
  void Function()? onPressed;
  CustomTextFieldWidget? reviewerNameTextField, reviewerCommentTextField;
  List<Widget>? childrenInActions;

  CustomAlertDialog({
    super.key,
    required this.purpose,
    this.onPressed,
    this.reviewerNameTextField,
    this.reviewerCommentTextField,
    this.childrenInActions,
  });

  @override
  Widget build(BuildContext context) {
    switch (purpose) {
      case 'exitAlert':
        return _buildExitAlertDialog(context);
      case 'internetConnectionAlert':
        return _buildNoInternetDialog(context);
      case 'addCommentAlert':
        return _addCommentDialog(context);
      default:
        throw ArgumentError("Invalid Purpose $purpose");
    }
  }

  Widget _addCommentDialog(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Give us your review ")),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: ListTile(
              title: reviewerNameTextField,
              subtitle: reviewerCommentTextField,
            ),
          ),
        ),
      ),
      actions: childrenInActions,
    );
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
            CustomElevatedButtonWidget(
              buttonLabel: 'No',
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CustomElevatedButtonWidget(
              buttonLabel: 'Yes',
              onPressed: () => Navigator.of(context).pop(true),
            )
          ],
        ),
      ],
    );
  }
}
