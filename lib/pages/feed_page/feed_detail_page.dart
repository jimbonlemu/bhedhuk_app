import 'dart:math';
import 'dart:ui';
import 'package:bhedhuk_app/provider/feed_database_provider.dart';
import 'package:lottie/lottie.dart';
import '../../../provider/feed_review_provider.dart';
import '../../../utils/images.dart';
import '../../../widgets/custom_alert_dialog_widget.dart';
import '../../../widgets/custom_elevated_button_widget.dart';
import '../../../widgets/custom_snack_bar_widget.dart';
import '../../../widgets/custom_text_field_widget.dart';
import '../../../widgets/pagination_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/api/api_service.dart';
import '../../../provider/feed_provider.dart';
import '../../../provider/utils_provider.dart';
import '../../../utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/detail_feed_provider.dart';
import '../../../widgets/custom_appbar_widget.dart';
import '../../../widgets/icon_title_widget.dart';
import '../../../widgets/menu_widget.dart';
import 'package:draggable_fab/draggable_fab.dart';
import '../../data/models/object_customer_review_api_response.dart';
import '../../data/models/object_of_restaurant.dart';
import '../../data/models/object_of_restaurant_detail.dart';
import '../../data/models/object_restaurant_detail_api_response.dart';

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

  bool validateUserInput(String nameValue, String commentValue) {
    if (nameValue.isEmpty) {
      CustomSnackBarWidget.notice(context,
          "Make sure to fill in the name field and avoid leaving it blank!");
      return false;
    } else if (commentValue.isEmpty) {
      CustomSnackBarWidget.notice(context,
          "Don't forget to fill in the comment field when posting your response! It's important to include your thoughts and ideas.");
      return false;
    } else if (nameValue.length < 3) {
      CustomSnackBarWidget.notice(
          context, "Enter a name with a minimum of three characters! ");
      return false;
    } else if (commentValue.length < 5) {
      CustomSnackBarWidget.notice(context,
          "Don't forget to take advantage of comments! They're a great way to add extra information and engage with your audience. Keep in mind that comments should be at least 5 characters long.");
      return false;
    }
    return true;
  }

  void commentResponseHandler(FeedReviewProvider feedReviewProvider) {
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
            final restaurantDetails =
                detailFeedProvider.objectOfRestaurantDetailApiResponse;
            int itemsPerPage = 3;
            int selectedPage = utilsProvider.selectedPageListOfComment;
            int startIndex = (selectedPage - 1) * itemsPerPage;
            int endIndex = min(
                startIndex + itemsPerPage,
                restaurantDetails.objectOfRestaurantDetail
                    .listObjectOfCustomerReviews.length);
            var pageItems = detailFeedProvider
                .objectOfRestaurantDetailApiResponse
                .objectOfRestaurantDetail
                .listObjectOfCustomerReviews
                .reversed
                .toList()
                .sublist(startIndex, endIndex);
            if (detailFeedProvider.responseResult == ResponseResult.loading) {
              var sizeHeight = MediaQuery.of(context).size.height;
              return _buildShimmer(sizeHeight);
            } else if (detailFeedProvider.responseResult ==
                ResponseResult.noData) {
              return _buildErrorAndNoData();
            } else if (detailFeedProvider.responseResult ==
                ResponseResult.error) {
              return _buildErrorAndNoData();
            } else {
              return _buildItemDetail(
                utilsProvider: utilsProvider,
                restaurantDetails: restaurantDetails,
                pageItems: pageItems,
                itemsPerPage: itemsPerPage,
                selectedPage: selectedPage,
              );
            }
          },
        ),
        floatingActionButton: Consumer2<DetailFeedProvider, FeedReviewProvider>(
          builder: (context, detailFeedProvider, feedReviewProvider, child) {
            if (detailFeedProvider.responseResult == ResponseResult.hasData) {
              return ChangeNotifierProvider<FeedReviewProvider>(
                create: (context) => FeedReviewProvider(),
                child: Consumer<FeedReviewProvider>(
                  builder: (context, feedReviewProvider, child) =>
                      _buildCommentPopUp(
                    context: context,
                    feedReviewProvider: feedReviewProvider,
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Column _buildErrorAndNoData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset(Images.lottieError),
        const Text("Sorry our service suddenly running out"),
      ],
    );
  }

  Widget _buildShimmer(double sizeHeight) {
    return Shimmer.fromColors(
      baseColor: shimmerBaseColor,
      highlightColor: shimmerHighligtColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: sizeHeight * 0.4,
              width: double.infinity,
              color: whiteColor,
            ),
            Padding(
              padding: const EdgeInsets.all(7),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: double.infinity,
                  height: sizeHeight * 0.6,
                  color: whiteColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: whiteColor,
                  width: double.infinity,
                  height: sizeHeight * 0.1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItemDetail({
    required UtilsProvider utilsProvider,
    required ObjectOfRestaurantDetailApiResponse restaurantDetails,
    required List<ObjectOfCustomerReviewApiResponse> pageItems,
    required int itemsPerPage,
    required int selectedPage,
  }) {
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
                restaurantDetails.objectOfRestaurantDetail.pictureId, 'medium'),
            fit: BoxFit.cover,
          ),
          imageTitle: Text(
            restaurantDetails.objectOfRestaurantDetail.name,
            style: utilsProvider.scrollController.hasClients &&
                    utilsProvider.scrollController.position.pixels > 200
                ? bhedhukTextTheme.headlineSmall
                : bhedhukTextTheme.headlineSmall!.copyWith(color: whiteColor),
          ),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: true,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(50),
                    color: whiteColor,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLocationAndStar(
                            objectOfRestaurantDetail:
                                restaurantDetails.objectOfRestaurantDetail,
                          ),
                          const SizedBox(height: 20),
                          _buildAboutRestaurant(
                            objectOfRestaurantDetail:
                                restaurantDetails.objectOfRestaurantDetail,
                          ),
                          const SizedBox(height: 20),
                          _buildFoodAndDrink(
                            objectOfRestaurantDetail:
                                restaurantDetails.objectOfRestaurantDetail,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _buildListOfComment(
              pageItems: pageItems,
              restaurantDetails: restaurantDetails,
              itemsPerPage: itemsPerPage,
              selectedPage: selectedPage,
              utilsProvider: utilsProvider,
            )
          ],
        );
      },
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
          child: Consumer<FeedDatabaseProvider>(
            builder: (context, feedDatabaseProvider, child) {
              return FutureBuilder<bool>(
                future: feedDatabaseProvider.isFavorited(widget.restaurantId),
                builder: (context, snapshot) {
                  var isFavorited = snapshot.data ?? false;
                  var instanceObjectOfRestaurant = ObjectOfRestaurant(
                      id: objectOfRestaurantDetail.id,
                      name: objectOfRestaurantDetail.name,
                      description: objectOfRestaurantDetail.description,
                      pictureId: objectOfRestaurantDetail.pictureId,
                      city: objectOfRestaurantDetail.city,
                      rating: objectOfRestaurantDetail.rating);
                  return isFavorited
                      ? IconButton(
                          onPressed: () {
                            feedDatabaseProvider
                                .removeFavoritedRestaurant(widget.restaurantId);
                            CustomSnackBarWidget.facts(context,
                                "You removed ${objectOfRestaurantDetail.name} from you're Favorited Feed");
                          },
                          color: Theme.of(context).colorScheme.secondary,
                          icon: const IconTitleWidget(
                            icon: Icons.favorite,
                          ))
                      : IconButton(
                          onPressed: () {
                            feedDatabaseProvider.addFavoritedRestaurant(
                                instanceObjectOfRestaurant);
                            CustomSnackBarWidget.victory(context,
                                "Success added ${objectOfRestaurantDetail.name} as you're Favorited Feed!");
                          },
                          color: Theme.of(context).colorScheme.secondary,
                          icon: const IconTitleWidget(
                            icon: Icons.favorite_border,
                          ),
                        );
                },
              );
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
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Our Address : ',
                style: bhedhukTextTheme.titleLarge!.copyWith(color: blackColor),
              ),
              TextSpan(
                text: objectOfRestaurantDetail.address,
                style: bhedhukTextTheme.bodyMedium!.copyWith(
                  color: blackColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: 'Our food categories: ',
                  style:
                      bhedhukTextTheme.titleLarge!.copyWith(color: blackColor)),
              TextSpan(
                  text: objectOfRestaurantDetail.categories.toList().join(', '),
                  style:
                      bhedhukTextTheme.bodyMedium!.copyWith(color: blackColor)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: 'About ${objectOfRestaurantDetail.name} :\n',
                  style:
                      bhedhukTextTheme.titleLarge!.copyWith(color: blackColor)),
              TextSpan(
                  text: objectOfRestaurantDetail.description,
                  style:
                      bhedhukTextTheme.bodyMedium!.copyWith(color: blackColor)),
            ],
          ),
        ),
        const SizedBox(height: 10),
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

  Widget _buildListOfComment({
    required List<ObjectOfCustomerReviewApiResponse> pageItems,
    required ObjectOfRestaurantDetailApiResponse restaurantDetails,
    required int itemsPerPage,
    required int selectedPage,
    required UtilsProvider utilsProvider,
  }) {
    return SliverList.builder(
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
                leading: CircleAvatar(
                    backgroundColor: result.backGroundColor,
                    child: const Icon(Icons.person)),
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: PaginationWidget(
                pageCount: (restaurantDetails.objectOfRestaurantDetail
                            .listObjectOfCustomerReviews.length /
                        itemsPerPage)
                    .ceil(),
                selectedPage: selectedPage,
                itemToDisplay: 3,
                onChanged: (page) {
                  if (page != selectedPage) {
                    utilsProvider.setSelectedPageListOfComment(page);
                  }
                }),
          );
        }
      },
    );
  }

  Widget _buildCommentPopUp({
    required BuildContext context,
    required FeedReviewProvider feedReviewProvider,
  }) {
    return DraggableFab(
      securityBottom: 100,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Tooltip(
          message: "Add your review",
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomElevatedButtonWidget(
                            buttonLabel: "Cancel",
                            onPressed: () {
                              reviewerNameController.text = "";
                              reviewerCommentController.text = "";
                              Navigator.of(context).pop(false);
                            },
                          ),
                          CustomElevatedButtonWidget(
                            isLoading: feedReviewProvider.isLoading,
                            buttonLabel: "Post Review",
                            onPressed: () async {
                              String nameValue =
                                  reviewerNameController.text.trim();
                              String commentValue =
                                  reviewerCommentController.text.trim();

                              if (validateUserInput(nameValue, commentValue)) {
                                await feedReviewProvider.postComment(
                                    widget.restaurantId,
                                    reviewerNameController.text,
                                    reviewerCommentController.text);

                                commentResponseHandler(feedReviewProvider);
                              }
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
    );
  }
}
