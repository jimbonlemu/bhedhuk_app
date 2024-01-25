import 'dart:ui';
import 'dart:math';
import 'package:bhedhuk_app/data/models/old_data_models/list_restaurant.dart';
import 'package:bhedhuk_app/data/models/old_data_models/restaurant.dart';
import 'package:bhedhuk_app/pages/utils_page/error_page.dart';
import 'package:bhedhuk_app/pages/feed_page/feed_detail_page.dart';
import 'package:bhedhuk_app/widgets/custom_appbar_widget.dart';
import 'package:bhedhuk_app/widgets/icon_title_widget.dart';
import 'package:bhedhuk_app/widgets/pagination_widget.dart';
import 'package:bhedhuk_app/widgets/rating_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FeedListPage extends StatefulWidget {
  static const route = '/feeds_page';
  const FeedListPage({super.key});

  @override
  State<FeedListPage> createState() => _FeedListPageState();
}

class _FeedListPageState extends State<FeedListPage> {
  int selectedPage = 1;
  int itemsPerPage = 3;

  setSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Feeds For You',
      ),
      body: _buildListFeedList(context),
    );
  }

  Widget _buildListFeedList(BuildContext context) {
    return FutureBuilder<ListOfRestaurant>(
      future: fetchListOfRestaurant(),
      builder: (context, snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return _buildShimmer(snapshot);
        } else {
          if (snapshot.hasData) {
            int startIndex = (selectedPage - 1) * itemsPerPage;
            int endIndex = min(
                startIndex + itemsPerPage, snapshot.data!.restaurants.length);

            var pageItems =
                snapshot.data!.restaurants.sublist(startIndex, endIndex);
            return ListView.builder(
              itemCount: pageItems.length + 1,
              itemBuilder: (context, index) {
                if (index < pageItems.length) {
                  var restaurant = pageItems[index];
                  precacheImage(NetworkImage(restaurant.pictureId), context);
                  return _buildFeedItem(context, restaurant);
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: PaginationWidget(
                      pageCount:
                          (snapshot.data!.restaurants.length / itemsPerPage)
                              .ceil(),
                      selectedPage: selectedPage,
                      itemToDisplay: 3,
                      onChanged: (page) {
                        if (page != selectedPage) {
                          setState(() {
                            selectedPage = page;
                          });
                        }
                      },
                    ),
                  );
                }
              },
            );
          } else if (snapshot.hasError) {
            return const ErrorPage();
          } else {
            return const Material(child: Text(''));
          }
        }
      },
    );
  }

  Widget _buildFeedItem(BuildContext context, Restaurant restaurant) {
    return GestureDetector(
      onLongPress: () {
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: Colors.black45,
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext buildContext, Animation animation,
              Animation secondaryAnimation) {
            return Center(
              child: InteractiveViewer(
                  clipBehavior: Clip.none,
                  minScale: 0.1,
                  maxScale: 2.0,
                  child: Image.network(restaurant.pictureId)),
            );
          },
          transitionBuilder: (context, animation, secondaryAnimation, child) {
            return BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 4 * animation.value, sigmaY: 4 * animation.value),
              child: child,
            );
          },
        );
      },
      onTap: () {
        Navigator.pushNamed(context, FeedDetailPage.route,
            arguments: restaurant);
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            color: Colors.white38,
            child: Wrap(
              children: [
                _buildImageHeader(context, restaurant),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildDescription(context, restaurant)),
                    Expanded(
                      child: IconTitleWidget(
                        restaurant: restaurant,
                        icon: Icons.place_outlined,
                        text: restaurant.city,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageHeader(BuildContext context, Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Stack(
          children: [
            Image.network(
              restaurant.pictureId,
              color: Colors.amber[200],
              colorBlendMode: BlendMode.darken,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                ),
                child: Container(
                  color: Colors.white.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      restaurant.name,
                      style: const TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context, Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingBarWidget(
            rating: restaurant.rating.toDouble(),
          ),
          const SizedBox(height: 5),
          Text(
            'Our Rating : ${restaurant.rating}/5',
          ),
          const SizedBox(height: 5),
          Text(
            'We provides ${restaurant.getMenuFoods.length} meal options ',
          ),
          const SizedBox(height: 5),
          Text(
            'We serves ${restaurant.getMenuDrinks.length} drinks',
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer(AsyncSnapshot snapshot) {
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
