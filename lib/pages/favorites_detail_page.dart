import 'package:bhedhuk_app/data/models/restaurant.dart';
import 'package:flutter/material.dart';

class FavoritesDetailPage extends StatefulWidget {
  static const route = '/favorites_detail_page';

  final Restaurant restaurant;
  const FavoritesDetailPage({super.key, required this.restaurant});

  @override
  State<FavoritesDetailPage> createState() => _FavoritesDetailPageState();
}

class _FavoritesDetailPageState extends State<FavoritesDetailPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
