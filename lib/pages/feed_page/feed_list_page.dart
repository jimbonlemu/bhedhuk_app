import 'dart:math';
import 'package:lottie/lottie.dart';

import '../../provider/utils_provider.dart';
import '../../provider/feed_list_provider.dart';
import '../../utils/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/feed_provider.dart';
import '../../widgets/custom_appbar_widget.dart';
import '../../widgets/feed_item_widget.dart';
import '../../widgets/general_shimmer_widget.dart';
import '../../widgets/pagination_widget.dart';

class FeedListPage extends StatefulWidget {
  static const route = '/feeds_list_page';
  const FeedListPage({super.key});

  @override
  State<FeedListPage> createState() => _FeedListPageState();
}

class _FeedListPageState extends State<FeedListPage> {
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
        int selectedPage = utilsProvider.selectedPageListOfRestaurant;
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
          return _buildErrorAndNoData();
        } else if (feedListProvider.responseResult == ResponseResult.error) {
          return _buildErrorAndNoData();
        } else {
          return _buildErrorAndNoData();
        }
      },
    );
  }

  Column _buildErrorAndNoData() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      LottieBuilder.asset(Images.lottieError),
      const Text('Sorry our service currently running out of service')
    ]);
  }

  Widget _buildPagination({
    required FeedListProvider feedListProvider,
    required int selectedPage,
    required int itemsPerPage,
    required UtilsProvider utilsProvider,
  }) {
    var objectLength = feedListProvider
        .getListOfRestaurantObjectApiResponse.listobjectOfRestaurant.length;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: PaginationWidget(
        pageCount: (objectLength / itemsPerPage).ceil(),
        selectedPage: selectedPage,
        itemToDisplay: 3,
        onChanged: (page) {
          if (page != selectedPage) {
            utilsProvider.setSelectedPageListOfRestaurant(page);
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
