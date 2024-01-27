import 'package:bhedhuk_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomWidgetShimmer extends StatelessWidget {
  final Widget child;
  const CustomWidgetShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: shimmerBaseColor,
      highlightColor: shimmerHighligtColor,
      child: child,
    );
  }
}
