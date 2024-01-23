import 'package:bhedhuk_app/data/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarWidget extends StatelessWidget {
  final double? rating;

  const RatingBarWidget({
    super.key,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      ignoreGestures: true,
      unratedColor: secondaryColor,
      itemSize: 30,
      initialRating: rating ?? 0.0,
      allowHalfRating: true,
      itemCount: 5,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        size: 5,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
