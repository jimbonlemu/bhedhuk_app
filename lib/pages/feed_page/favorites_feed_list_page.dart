import 'package:bhedhuk_app/pages/feed_page/feed_settings_page.dart';
import 'package:bhedhuk_app/provider/feed_database_provider.dart';
import 'package:bhedhuk_app/provider/feed_provider.dart';
import 'package:bhedhuk_app/utils/images.dart';
import 'package:bhedhuk_app/widgets/feed_item_widget.dart';
import 'package:bhedhuk_app/widgets/general_shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<FeedDatabaseProvider>(
        builder: (context, feedDatabaseProvider, child) {
          if (feedDatabaseProvider.result == ResponseResult.hasData) {
            return ListView.builder(
              itemCount: feedDatabaseProvider.listOfFavoritedRestaurant.length,
              itemBuilder: (context, index) {
                return FeedItemWidget(
                    restaurant:
                        feedDatabaseProvider.listOfFavoritedRestaurant[index]);
              },
            );
          } else if (feedDatabaseProvider.result == ResponseResult.loading) {
            return const GeneralShimmerWidget();
          } else {
            return Center(
              child: LottieBuilder.asset(Images.lottieNoFavorites),
            );
          }
        },
      ),
    );
  }
}
