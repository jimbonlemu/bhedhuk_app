import 'dart:math';
import 'package:bhedhuk_app/provider/utils_provider.dart';
import 'package:bhedhuk_app/provider/feed_list_provider.dart';
import 'package:bhedhuk_app/utils/images.dart';
import 'package:bhedhuk_app/utils/styles.dart';
import 'package:bhedhuk_app/widgets/custom_appbar_widget.dart';
import 'package:bhedhuk_app/widgets/feed_item_widget.dart';
import 'package:bhedhuk_app/widgets/pagination_widget.dart';
import 'package:bhedhuk_app/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/feed_provider.dart';

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
    return Consumer2<FeedListProvider, UtilsProvider>(
      builder: (context, feedListProvider, utilsProvider, _) {
        int selectedPage = utilsProvider.selectedPage;
        if (feedListProvider.responseResult == ResponseResult.loading) {
          return _buildShimmer();
        } else if (feedListProvider.responseResult == ResponseResult.hasData) {
          int startIndex = (selectedPage - 1) * itemsPerPage;
          int endIndex = min(startIndex + itemsPerPage,
              feedListProvider.getListOfRestaurantObjectResponse.count);

          var pageItems = feedListProvider
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
                return FeedItemWidget(
                  restaurant: restaurant,
                );
              } else {
                return _buildPagination(
                  feedListProvider: feedListProvider,
                  selectedPage: selectedPage,
                  itemsPerPage: itemsPerPage,
                  utilsProvider: utilsProvider,
                );
              }
            },
          );
        } else if (feedListProvider.responseResult == ResponseResult.noData) {
          return Center(
            child: Material(
              child: Text(feedListProvider.messageResponse),
            ),
          );
        } else if (feedListProvider.responseResult == ResponseResult.error) {
          print(feedListProvider.messageResponse);
          return Center(
            child: Material(
              child: Text(feedListProvider.messageResponse),
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

  Widget _buildPagination({
    required FeedListProvider feedListProvider,
    required int selectedPage,
    required int itemsPerPage,
    required UtilsProvider utilsProvider,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: PaginationWidget(
        pageCount: (feedListProvider.getListOfRestaurantObjectResponse
                    .listobjectOfRestaurant.length /
                itemsPerPage)
            .ceil(),
        selectedPage: selectedPage,
        itemToDisplay: 3,
        onChanged: (page) {
          if (page != selectedPage) {
            // setState(() {
            //   _showShimmer = true;
            //   Future.delayed(const Duration(seconds: 1), () {
            //     if (mounted) {
            //       setState(() {
            //         _showShimmer = false;
            //       });
            //     }
            //   });
            // });
            utilsProvider.setSelectedPage(page);
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
    return CustomWidgetShimmer(
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
                          color: whiteColor,
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
                          color: whiteColor,
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
