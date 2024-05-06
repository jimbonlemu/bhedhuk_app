import 'dart:math';
import 'package:feed_me/data/models/object_of_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../feed_page/feed_settings_page.dart';
import '../../provider/feed_database_provider.dart';
import '../../provider/utils_provider.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../../widgets/custom_general_search_bar_widget.dart';
import '../../widgets/feed_item_widget.dart';
import '../../widgets/general_shimmer_widget.dart';
import '../../widgets/pagination_widget.dart';
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
            int selectedPage = utilsProvider.selectedPageListFavorited;
            int startIndex = (selectedPage - 1) * 3;
            int endIndex = min(startIndex + itemsPerPage,
                feedDatabaseProvider.listOfFavoritedRestaurant.length);

            var pageItems = feedDatabaseProvider.listOfFavoritedRestaurant
                .sublist(startIndex, endIndex);
            return _buildAnyListOfFavoritedAndSearched(
              feedDatabaseProvider: feedDatabaseProvider,
              utilsProvider: utilsProvider,
              pageItems: pageItems,
              selectedPage: selectedPage,
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

  Widget _buildAnyListOfFavoritedAndSearched({
    required FeedDatabaseProvider feedDatabaseProvider,
    required UtilsProvider utilsProvider,
    required List<ObjectOfRestaurant> pageItems,
    required int selectedPage,

  }) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        CustomGeneralSliverSearchBarWidget(
            controller: searchController,
            hintText: "Find your favorite restaurant by name..",
            onSubmitted: (value) {
              feedDatabaseProvider.searchRestaurant(searchController.text).then(
                  (value) => utilsProvider.setSelectedPageListOfFavorited(1));
            }),
        if (searchController.text.isNotEmpty)
          SliverList.builder(
            itemCount: feedDatabaseProvider.searchResultFavorited.length,
            itemBuilder: (context, index) {
              var listSearchedFavorited =
                  feedDatabaseProvider.searchResultFavorited[index];
              return FeedItemWidget(restaurant: listSearchedFavorited);
            },
          ),
        if (searchController.text.isEmpty)
          _buildListOfFavorited(
            pageItems: pageItems,
            feedDatabaseProvider: feedDatabaseProvider,
            selectedPage: selectedPage,
            utilsProvider: utilsProvider,
          ),
      ],
    );
  }

  Widget _buildListOfFavorited({
    required List<ObjectOfRestaurant> pageItems,
    required FeedDatabaseProvider feedDatabaseProvider,
    required int selectedPage,
    required UtilsProvider utilsProvider,
  }) {
    return SliverList.builder(
      itemCount: pageItems.length + 1,
      itemBuilder: (context, index) {
        if (index < pageItems.length) {
          var listFavorited = pageItems[index];
          return FeedItemWidget(restaurant: listFavorited);
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: PaginationWidget(
              pageCount:
                  (feedDatabaseProvider.listOfFavoritedRestaurant.length /
                          itemsPerPage)
                      .ceil(),
              selectedPage: selectedPage,
              onChanged: (page) {
                if (page != selectedPage) {
                  utilsProvider.setSelectedPageListOfFavorited(page);
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
    );
  }
}
