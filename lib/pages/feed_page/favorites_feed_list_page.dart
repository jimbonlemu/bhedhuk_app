import 'dart:math';
import 'package:bhedhuk_app/pages/feed_page/feed_settings_page.dart';
import 'package:bhedhuk_app/provider/feed_database_provider.dart';
import 'package:bhedhuk_app/provider/utils_provider.dart';
import 'package:bhedhuk_app/utils/images.dart';
import 'package:bhedhuk_app/utils/styles.dart';
import 'package:bhedhuk_app/widgets/custom_general_search_bar_widget.dart';
import 'package:bhedhuk_app/widgets/feed_item_widget.dart';
import 'package:bhedhuk_app/widgets/general_shimmer_widget.dart';
import 'package:bhedhuk_app/widgets/pagination_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../utils/enum_state.dart';
import '../../widgets/custom_appbar_widget.dart';

class FavoritesListPage extends StatefulWidget {
  static const route = '/feed_favorites_page';

  const FavoritesListPage({super.key});

  @override
  State<FavoritesListPage> createState() => _FavoritesListPageState();
}

class _FavoritesListPageState extends State<FavoritesListPage> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: "You're Favorited Feeds",
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
      body: Consumer2<FeedDatabaseProvider, UtilsProvider>(
        builder: (context, feedDatabaseProvider, utilsProvider, child) {
          if (feedDatabaseProvider.result == ResponseResult.hasData) {
            int itemsPerPage = 3;
            int selectedPage = utilsProvider.selectedPageListFavorited;
            int startIndex = (selectedPage - 1) * 3;
            int endIndex = min(startIndex + itemsPerPage,
                feedDatabaseProvider.listOfFavoritedRestaurant.length);

            var pageItems = feedDatabaseProvider.listOfFavoritedRestaurant
                .sublist(startIndex, endIndex);
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                CustomGeneralSliverSearchBarWidget(
                    controller: searchController,
                    hintText: "Find your favorite restaurant by name..",
                    onSubmitted: (value) {
                      feedDatabaseProvider
                          .searchRestaurant(searchController.text)
                          .then((value) =>
                              utilsProvider.setSelectedPageListOfFavorited(1));
                    }),
                if (searchController.text.isNotEmpty)
                  SliverList.builder(
                    itemCount:
                        feedDatabaseProvider.searchResultFavorited.length,
                    itemBuilder: (context, index) {
                      var listSearchedFavorited =
                          feedDatabaseProvider.searchResultFavorited[index];
                      return FeedItemWidget(restaurant: listSearchedFavorited);
                    },
                  ),
                if (searchController.text.isEmpty)
                  SliverList.builder(
                    itemCount: pageItems.length + 1,
                    itemBuilder: (context, index) {
                      if (index < pageItems.length) {
                        var listFavorited = pageItems[index];
                        return FeedItemWidget(restaurant: listFavorited);
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: PaginationWidget(
                            pageCount: (feedDatabaseProvider
                                        .listOfFavoritedRestaurant.length /
                                    itemsPerPage)
                                .ceil(),
                            selectedPage: selectedPage,
                            onChanged: (page) {
                              if (page != selectedPage) {
                                utilsProvider
                                    .setSelectedPageListOfFavorited(page);
                                _scrollController.animateTo(
                                  0.0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOut,
                                );
                              }
                            },
                          ),
                        );
                      }
                    },
                  ),
              ],
            );
          } else if (feedDatabaseProvider.result == ResponseResult.loading) {
            return const GeneralShimmerWidget();
          } else {
            return Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  LottieBuilder.asset(Images.lottieNoFavorites),
                  Text(
                    "You haven't got any saved Feeds.",
                    style: feedMeTextTheme.headlineSmall,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
