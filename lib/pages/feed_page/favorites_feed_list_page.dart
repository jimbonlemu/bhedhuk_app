import 'package:bhedhuk_app/pages/feed_page/feed_settings_page.dart';
import 'package:bhedhuk_app/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/custom_appbar_widget.dart';

class FavoritesListPage extends StatefulWidget {
  static const route = '/feed_favorites_page';

  const FavoritesListPage({super.key});

  @override
  State<FavoritesListPage> createState() => _FavoritesListPageState();
}

class _FavoritesListPageState extends State<FavoritesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Feeds For You',
        actionList: [
          IconButton(
            tooltip: "Feed Settings",
            onPressed: () {
              Navigator.pushNamed(context, FeedSettingsPage.route);
            },
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: Center(
        child: LottieBuilder.asset(Images.lottieNoFavorites),
        //     Text(
        //   'Coming Soon !',
        //   style: bhedhukTextTheme.titleLarge,
        // ),
      ),
    );
  }
}
