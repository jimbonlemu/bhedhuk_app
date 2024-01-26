import 'dart:math';
import 'package:bhedhuk_app/provider/feed_list_page_provider.dart';
import 'package:bhedhuk_app/provider/restaurant_provider.dart';
import 'package:bhedhuk_app/utils/images.dart';
import 'package:bhedhuk_app/widgets/custom_appbar_widget.dart';
import 'package:bhedhuk_app/widgets/feed_item_widget.dart';
import 'package:bhedhuk_app/widgets/pagination_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class FeedListPage extends StatelessWidget {
  static const route = '/feeds_page';
  FeedListPage({super.key});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Feeds For You',
      ),
      body: _buildListRestaurant(context),
    );
  }

  Widget _buildListRestaurant(BuildContext context) {
    int itemsPerPage = 3;
    return Consumer2<RestaurantProvider, FeedListPageProvider>(
      builder: (context, restaurantProvider, feedListPageProvider, _) {
        int selectedPage = feedListPageProvider.selectedPage;
        if (restaurantProvider.responseResult == ResponseResult.loading) {
          return _buildShimmer();
        } else if (restaurantProvider.responseResult ==
            ResponseResult.hasData) {
          int startIndex = (selectedPage - 1) * itemsPerPage;
          int endIndex = min(startIndex + itemsPerPage,
              restaurantProvider.getListOfRestaurantObjectResponse.count);

          var pageItems = restaurantProvider
              .getListOfRestaurantObjectResponse.listobjectOfRestaurant
              .sublist(startIndex, endIndex);
          return ListView.builder(
            controller: _scrollController,
            itemCount: pageItems.length + 1,
            itemBuilder: (context, index) {
              if (index < pageItems.length) {
                var restaurant = pageItems[index];
                precacheImage(
                    NetworkImage(Images.instanceImages
                        .getImageSize(restaurant.pictureId, 'medium')),
                    context);
                return FeedItemWidget(restaurant: restaurant);
              } else {
                return _buildPagination(
                    restaurantProvider: restaurantProvider,
                    selectedPage: selectedPage,
                    itemsPerPage: itemsPerPage,
                    feedListPageProvider: feedListPageProvider);
              }
            },
          );
        } else if (restaurantProvider.responseResult == ResponseResult.noData) {
          return Center(
            child: Material(
              child: Text(restaurantProvider.messageResponse),
            ),
          );
        } else if (restaurantProvider.responseResult == ResponseResult.error) {
          print(restaurantProvider.messageResponse);
          return Center(
            child: Material(
              child: Text(restaurantProvider.messageResponse),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

  Widget _buildPagination(
      {required RestaurantProvider restaurantProvider,
      required int selectedPage,
      required int itemsPerPage,
      required FeedListPageProvider feedListPageProvider}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: PaginationWidget(
        pageCount: (restaurantProvider.getListOfRestaurantObjectResponse
                    .listobjectOfRestaurant.length /
                itemsPerPage)
            .ceil(),
        selectedPage: selectedPage,
        itemToDisplay: 3,
        onChanged: (page) {
          if (page != selectedPage) {
            feedListPageProvider.setSelectedPage(page);
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

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (_, __) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          color: Colors.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
