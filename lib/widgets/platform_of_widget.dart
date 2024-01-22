import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformOfWidget extends StatelessWidget {
  final WidgetBuilder androidUserBuilder, iosUserBuilder;
  const PlatformOfWidget({
    super.key,
    required this.androidUserBuilder,
    required this.iosUserBuilder,
  });

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidUserBuilder(context);
      case TargetPlatform.iOS:
        return iosUserBuilder(context);
      default:
        return androidUserBuilder(context);
    }
    
  }
}
