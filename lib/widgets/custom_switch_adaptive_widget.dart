
import 'package:flutter/material.dart';

import '../utils/styles.dart';

class CustomSwitchAdaptiveWidget extends StatelessWidget {
  final bool changedValue;
  final void Function(bool)? onChanged;
  const CustomSwitchAdaptiveWidget({
    super.key,
    required this.changedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      activeTrackColor: primaryColor,
      inactiveTrackColor: blackColor,
      activeColor: blackColor,
      inactiveThumbColor: primaryColor,
      trackOutlineColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return blackColor;
      }),
      value: changedValue,
      onChanged: onChanged,
    );
  }
}
