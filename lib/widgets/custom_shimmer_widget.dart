import 'package:bhedhuk_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomWidgetShimmer extends StatelessWidget {
  final Widget child;
  final Duration? duration;
  const CustomWidgetShimmer({super.key, required this.child, this.duration});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: duration ?? const Duration(seconds: 3),
      baseColor: shimmerBaseColor,
      highlightColor: shimmerHighligtColor,
      child: child,
    );
  }
}
