import 'dart:ui';

import 'package:bhedhuk_app/utils/images.dart';
import 'package:bhedhuk_app/widgets/custom_alert_dialog_widget.dart';
import '../../data/api/api_service.dart';
import '../../data/models/new_data_models/object_of_restaurant_detail.dart';
import '../../provider/feed_provider.dart';
import '../../provider/utils_provider.dart';
import '../../utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/detail_feed_item_provider.dart';
import '../../widgets/custom_appbar_widget.dart';
import '../../widgets/icon_title_widget.dart';
import '../../widgets/menu_widget.dart';
import 'package:draggable_fab/draggable_fab.dart';

class FeedDetailPage extends StatelessWidget {
  static const route = '/feed_detail_page';
  final String restaurantId;
  const FeedDetailPage({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailFeedProvider(
        apiService: ApiService(),
        restaurantId: restaurantId,
      ),
      child: Scaffold(
        body: Consumer2<DetailFeedProvider, UtilsProvider>(
          builder: (context, detailFeedProvider, utilsProvider, child) {
            if (detailFeedProvider.responseResult == ResponseResult.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (detailFeedProvider.responseResult ==
                ResponseResult.noData) {
              return const Center(child: Text('No data'));
            } else if (detailFeedProvider.responseResult ==
                ResponseResult.error) {
              return const Center(child: Text('An error occurred'));
            } else {
              final restaurantDetails =
                  detailFeedProvider.objectOfRestaurantDetailApiResponse;
              return AnimatedBuilder(
                animation: utilsProvider.scrollController,
                builder: (context, child) {
                  return CustomAppBarWidget(
                    iconTheme: utilsProvider.scrollController.hasClients &&
                            utilsProvider.scrollController.position.pixels > 200
                        ? const IconThemeData(color: blackColor)
                        : const IconThemeData(color: whiteColor),
                    scrollController: utilsProvider.scrollController,
                    disappearWhenScrolled: true,
                    image: Image.network(
                      Images.instanceImages.getImageSize(
                          restaurantDetails.objectOfRestaurantDetail.pictureId,
                          'medium'),
                      fit: BoxFit.cover,
                    ),
                    imageTitle: Text(
                      restaurantDetails.objectOfRestaurantDetail.name,
                      style: utilsProvider.scrollController.hasClients &&
                              utilsProvider.scrollController.position.pixels >
                                  200
                          ? bhedhukTextTheme.headlineSmall
                          : bhedhukTextTheme.headlineSmall!
                              .copyWith(color: whiteColor),
                    ),
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: true,
                        // fillOverscroll: true,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.all(50),
                              color: Colors.white,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLocationAndStar(
                                      objectOfRestaurantDetail:
                                          restaurantDetails
                                              .objectOfRestaurantDetail,
                                    ),
                                    const SizedBox(height: 20),
                                    _buildAboutRestaurant(
                                      objectOfRestaurantDetail:
                                          restaurantDetails
                                              .objectOfRestaurantDetail,
                                    ),
                                    const SizedBox(height: 20),
                                    _buildFoodAndDrink(
                                      objectOfRestaurantDetail:
                                          restaurantDetails
                                              .objectOfRestaurantDetail,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverList.builder(
                        itemCount: detailFeedProvider
                            .objectOfRestaurantDetailApiResponse
                            .objectOfRestaurantDetail
                            .listObjectOfCustomerReviews
                            .length,
                        itemBuilder: (context, index) {
                          var objetOfComment = detailFeedProvider
                              .objectOfRestaurantDetailApiResponse
                              .objectOfRestaurantDetail
                              .listObjectOfCustomerReviews[index];
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Card(
                              child: ListTile(
                                title: Text(objetOfComment.name),
                                subtitle: Text(objetOfComment.review),
                                trailing: Text(objetOfComment.date),
                              ),
                            ),
                          );
                        },
                      ),

                      // SliverList(
                      //   delegate: SliverChildBuilderDelegate(
                      //     (BuildContext context, int index) {
                      //       final comment = detailFeedProvider
                      //               .objectOfRestaurantDetailApiResponse
                      //               .objectOfRestaurantDetail
                      //               .listObjectOfCustomerReviews[
                      //           index]; // replace with your list of comments
                      //       return Card(
                      //         child: ListTile(
                      //           title: Text(comment.name),
                      //           subtitle: Text(comment.review),
                      //           trailing: Text(comment.date),
                      //         ),
                      //       );
                      //     },
                      //     childCount: restaurantDetails
                      //         .objectOfRestaurantDetail
                      //         .listObjectOfCustomerReviews
                      //         .length, // replace with your list of comments
                      //   ),
                      // )
                    ],
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: DraggableFab(
          securityBottom: 100,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Tooltip(
              message: "Add your review",
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(primaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: CustomAlertDialog(purpose: "addCommentAlert"),
                    ),
                  );
                },
                child: const Icon(
                  Icons.edit,
                  color: blackColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationAndStar(
      {required ObjectOfRestaurantDetail objectOfRestaurantDetail}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: IconTitleWidget(
            icon: Icons.place_outlined,
            text: objectOfRestaurantDetail.city,
          ),
        ),
        Expanded(
          child: IconTitleWidget(
            icon: Icons.star_border,
            text: objectOfRestaurantDetail.rating.toString(),
          ),
        ),
        Expanded(
          child: Consumer<UtilsProvider>(
            builder: (context, utilsProvider, child) {
              return IconButton(
                  onPressed: () {
                    utilsProvider.toggleFavorite();
                  },
                  icon: Icon(
                    utilsProvider.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: primaryColor,
                  ));
            },
          ),
        )
      ],
    );
  }

  Widget _buildAboutRestaurant(
      {required ObjectOfRestaurantDetail objectOfRestaurantDetail}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About ${objectOfRestaurantDetail.name} :',
            style: bhedhukTextTheme.titleLarge),
        const SizedBox(height: 10),
        Text(objectOfRestaurantDetail.description),
      ],
    );
  }

  Widget _buildFoodAndDrink(
      {required ObjectOfRestaurantDetail objectOfRestaurantDetail}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: MenuWidget(
              title: 'Our Foods Menu : ',
              objectToList: objectOfRestaurantDetail.getMenuFoods),
        ),
        Expanded(
          child: MenuWidget(
              title: 'Our Drinks Menu :',
              objectToList: objectOfRestaurantDetail.getMenuDrinks),
        ),
      ],
    );
  }
}
