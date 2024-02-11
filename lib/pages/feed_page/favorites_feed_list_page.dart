import 'package:bhedhuk_app/utils/styles.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_appbar_widget.dart';

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
      appBar: const CustomAppBarWidget(
        title: 'Feeds For You',
      ),
      body: Center(
        child: Text(
          'Coming Soon !',
          style: bhedhukTextTheme.titleLarge,
        ),
      ),
    );
  }
}
