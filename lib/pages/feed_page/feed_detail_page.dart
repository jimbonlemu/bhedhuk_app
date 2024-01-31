import 'dart:math';
import 'dart:ui';
import 'package:bhedhuk_app/provider/feed_review_provider.dart';
import 'package:bhedhuk_app/utils/images.dart';
import 'package:bhedhuk_app/widgets/custom_alert_dialog_widget.dart';
import 'package:bhedhuk_app/widgets/custom_elevated_button_widget.dart';
import 'package:bhedhuk_app/widgets/custom_snack_bar_widget.dart';
import 'package:bhedhuk_app/widgets/custom_text_field_widget.dart';
import 'package:bhedhuk_app/widgets/pagination_widget.dart';
import '../../data/api/api_service.dart';
import '../../data/models/new_data_models/object_of_restaurant_detail.dart';
import '../../provider/feed_provider.dart';
import '../../provider/utils_provider.dart';
import '../../utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/detail_feed_provider.dart';
import '../../widgets/custom_appbar_widget.dart';
import '../../widgets/icon_title_widget.dart';
import '../../widgets/menu_widget.dart';
import 'package:draggable_fab/draggable_fab.dart';

class FeedDetailPage extends StatefulWidget {
  static const route = '/feed_detail_page';
  final String restaurantId;
  const FeedDetailPage({super.key, required this.restaurantId});

  @override
  State<FeedDetailPage> createState() => _FeedDetailPageState();
}

class _FeedDetailPageState extends State<FeedDetailPage> {
  TextEditingController reviewerNameController = TextEditingController();
  TextEditingController reviewerCommentController = TextEditingController();

  void handlerIfSuccess(FeedReviewProvider feedReviewProvider) {
    if (feedReviewProvider.isPostCommentSuccessful == true) {
      Navigator.pop(context);
      CustomSnackBarWidget.victory(context, "Success Post You're Comment");

      Navigator.popAndPushNamed(context, FeedDetailPage.route,
          arguments: widget.restaurantId);
    } else {
      Navigator.pop(context);
      CustomSnackBarWidget.notice(context, "Failed to Post You're Comment");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailFeedProvider(
        apiService: ApiService(),
        restaurantId: widget.restaurantId,
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
              int itemsPerPage = 3;
              int selectedPage = 1;
              int startIndex = (selectedPage - 1) * itemsPerPage;
              int endIndex = min(
                  startIndex + itemsPerPage,
                  restaurantDetails.objectOfRestaurantDetail
                      .listObjectOfCustomerReviews.length);
              var pageItems = detailFeedProvider
                  .objectOfRestaurantDetailApiResponse
                  .objectOfRestaurantDetail
                  .listObjectOfCustomerReviews
                  .sublist(startIndex, endIndex);
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
                      if (restaurantDetails.objectOfRestaurantDetail
                          .listObjectOfCustomerReviews.isNotEmpty)
                        SliverList.builder(
                          itemCount: pageItems.length + 1,
                          itemBuilder: (context, index) {
                            if (index < pageItems.length) {
                              var result = pageItems[index];
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: Card(
                                  color: whiteColor,
                                  child: ListTile(
                                    title: Text(result.name),
                                    subtitle: Text(result.review),
                                    trailing: Text(result.date),
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: PaginationWidget(
                                    pageCount: (restaurantDetails
                                                .objectOfRestaurantDetail
                                                .listObjectOfCustomerReviews
                                                .length /
                                            itemsPerPage)
                                        .ceil(),
                                    selectedPage: selectedPage,
                                    itemToDisplay: 3,
                                    onChanged: (page) {
                                      if (page != selectedPage) {
                                        utilsProvider.setSelectedPage(page);
                                      }
                                    }),
                              );
                            }
                          },
                        )
                      else
                        SliverToBoxAdapter(
                          child: Container(),
                        )
                    ],
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: ChangeNotifierProvider<FeedReviewProvider>(
          create: (context) => FeedReviewProvider(apiService: ApiService()),
          child: Consumer<FeedReviewProvider>(
            builder: (context, feedReviewProvider, child) => DraggableFab(
              securityBottom: 100,
              child: Padding(
                padding: const EdgeInsets.all(20),
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
                          child: CustomAlertDialog(
                            purpose: "addCommentAlert",
                            reviewerNameTextField: CustomTextFieldWidget(
                              label: "Your name is ?",
                              textController: reviewerNameController,
                            ),
                            reviewerCommentTextField: CustomTextFieldWidget(
                              label: "Your review about us ?",
                              textController: reviewerCommentController,
                            ),
                            childrenInActions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomElevatedButtonWidget(
                                    buttonLabel: "Cancel",
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  ),
                                  CustomElevatedButtonWidget(
                                    isLoading: feedReviewProvider.isLoading,
                                    buttonLabel: "Post Review",
                                    onPressed: () async {
                                      await feedReviewProvider
                                          .postComment(
                                              widget.restaurantId,
                                              reviewerNameController.text,
                                              reviewerCommentController.text)
                                          .then((value) => handlerIfSuccess(
                                              feedReviewProvider));
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
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
