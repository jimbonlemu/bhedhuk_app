import 'package:bhedhuk_app/data/models/list_restaurant.dart';
import 'package:flutter/material.dart';

class FeedDetailPage extends StatefulWidget {
  static const route = '/feed_detail_page';
  final ListOfRestaurant restaurantId;
  const FeedDetailPage({super.key, required this.restaurantId});

  @override
  State<FeedDetailPage> createState() => _FeedDetailPageState();
}

class _FeedDetailPageState extends State<FeedDetailPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
