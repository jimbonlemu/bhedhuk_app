import 'dart:math';
import 'package:bhedhuk_app/provider/utils_provider.dart';
import 'package:bhedhuk_app/provider/feed_list_provider.dart';
import 'package:bhedhuk_app/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/feed_provider.dart';
import '../../widgets/custom_appbar_widget.dart';
import '../../widgets/feed_item_widget.dart';
import '../../widgets/general_shimmer_widget.dart';
import '../../widgets/pagination_widget.dart';


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
          return const GeneralShimmerWidget();
        } else if (feedListProvider.responseResult == ResponseResult.hasData) {
          int startIndex = (selectedPage - 1) * itemsPerPage;
          int endIndex = min(startIndex + itemsPerPage,
              feedListProvider.getListOfRestaurantObjectApiResponse.count);

          var pageItems = feedListProvider
              .getListOfRestaurantObjectApiResponse.listobjectOfRestaurant
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
        pageCount: (feedListProvider.getListOfRestaurantObjectApiResponse
                    .listobjectOfRestaurant.length /
                itemsPerPage)
            .ceil(),
        selectedPage: selectedPage,
        itemToDisplay: 3,
        onChanged: (page) {
          if (page != selectedPage) {
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
}
