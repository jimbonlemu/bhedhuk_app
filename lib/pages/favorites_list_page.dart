import 'package:bhedhuk_app/data/utils/styles.dart';
import 'package:flutter/material.dart';

class FavoritesListPage extends StatefulWidget {
  static const route = '/favorites_page';

  const FavoritesListPage({super.key});

  @override
  State<FavoritesListPage> createState() => _FavoritesListPageState();
}

class _FavoritesListPageState extends State<FavoritesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Coming Soon !',
          style: bhedhukTextTheme.titleLarge,
        ),
      ),
    );
  }
}
