import 'package:bhedhuk_app/utils/images.dart';

import '../../data/api/api_service.dart';
import '../../data/models/new_data_models/object_of_restaurant_detail.dart';
import '../../provider/utils_provider.dart';
import '../../utils/styles.dart';
import '../../widgets/custom_appbar_widget.dart';
import '../../widgets/icon_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/detail_feed_item_provider.dart';
import '../../utils/response_result.dart';
import '../../widgets/menu_widget.dart';

class FeedDetailPage extends StatelessWidget {
  static const route = '/feed_detail_page';
  final String restaurantId;
  FeedDetailPage({super.key, required this.restaurantId});

  final apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    // Provider.of<FeedListProvider>(context, listen: false)
    //     .fetchDetailRestaurant(restaurantId);
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: FutureBuilder(
    //     future: apiService.getRestaurantDetail('your_restaurant_id'),
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return CircularProgressIndicator();
    //       } else if (snapshot.hasError) {
    //         print(snapshot.error);
    //         return Text('Error: ${snapshot.error}');
    //       } else {
    //         // Assuming that getRestaurantDetail returns a RestaurantDetail object
    //         ObjectOfRestaurantDetail restaurantDetail = snapshot.data;
    //         return Text('Restaurant name: ${restaurantDetail.name}');
    //       }
    //     },
    //   ),
    // );
    //   return Scaffold(
    //     body: Consumer<FeedListProvider>(
    //       builder: (context, restaurantDetailProvider, child) {
    //         if (restaurantDetailProvider.responseResult ==
    //             ResponseResult.loading) {
    //           return const Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         } else if (restaurantDetailProvider.responseResult ==
    //             ResponseResult.hasData) {
    //           var resto = restaurantDetailProvider
    //               .getObjectOfRestaurantDetailObjectResponse
    //               .objectOfRestaurantDetail;
    //           return
    //               // _buildText(resto);
    //               // return Center(
    //               //   child:
    //               // );
    //               CustomAppBarWidget(
    //             disappearWhenScrolled: true,
    //             image: Image.network(
    //               widget.restaurant.pictureId,
    //               fit: BoxFit.cover,
    //             ),
    //             imageTitle: Text(
    //               widget.restaurant.name,
    //               style: bhedhukTextTheme.headlineSmall,
    //             ),
    //             slivers: [
    //               SliverFillRemaining(
    //                 hasScrollBody: true,
    //                 // fillOverscroll: true,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: ClipRRect(
    //                     borderRadius: BorderRadius.circular(20),
    //                     child: Container(
    //                       padding: const EdgeInsets.all(50),
    //                       color: Colors.white,
    //                       child: SingleChildScrollView(
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             _buildLocationAndStar(),
    //                             const SizedBox(height: 20),
    //                             _buildAboutRestaurant(),
    //                             const SizedBox(height: 20),
    //                             _buildFoodAndDrink(),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           );
    //         } else if (restaurantDetailProvider.responseResult ==
    //             ResponseResult.noData) {
    //           return Center(
    //             child: Material(
    //               child: Text(restaurantDetailProvider.messageResponse),
    //             ),
    //           );
    //         } else if (restaurantDetailProvider.responseResult ==
    //             ResponseResult.error) {
    //           print(restaurantDetailProvider.messageResponse);
    //           return Center(
    //             child: Material(
    //               child: Text(restaurantDetailProvider.messageResponse),
    //             ),
    //           );
    //         } else {
    //           return const Center(
    //             child: Material(
    //               child: Text(''),
    //             ),
    //           );
    //         }
    //       },
    //     ),
    //   );
    // }

    return ChangeNotifierProvider(
      create: (context) => DetailFeedProvider(
        apiService: ApiService(),
        id: restaurantId,
      ),
      child: Scaffold(
        body: Consumer<DetailFeedProvider>(
          builder: (context, detailFeedProvider, child) {
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
                  detailFeedProvider.objectOfRestaurantDetailObjectResponse;
              return CustomAppBarWidget(
                disappearWhenScrolled: true,
                image: Image.network(
                  Images.instanceImages.getImageSize(
                      restaurantDetails.objectOfRestaurantDetail.pictureId,
                      'small'),
                  fit: BoxFit.cover,
                ),
                imageTitle: Text(
                  restaurantDetails.objectOfRestaurantDetail.name,
                  style: bhedhukTextTheme.headlineSmall,
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
                                  objectOfRestaurantDetail: restaurantDetails
                                      .objectOfRestaurantDetail,
                                ),
                                const SizedBox(height: 20),
                                _buildAboutRestaurant(
                                  objectOfRestaurantDetail: restaurantDetails
                                      .objectOfRestaurantDetail,
                                ),
                                const SizedBox(height: 20),
                                _buildFoodAndDrink(
                                  objectOfRestaurantDetail: restaurantDetails
                                      .objectOfRestaurantDetail,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
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
