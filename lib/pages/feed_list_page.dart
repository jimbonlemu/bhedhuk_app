import 'package:bhedhuk_app/data/models/list_restaurant.dart';
import 'package:bhedhuk_app/data/models/restaurant.dart';

import 'package:bhedhuk_app/pages/feed_detail_page.dart';
import 'package:bhedhuk_app/widgets/custom_appbar_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Feeds For You',
      ),
      body: _buildListFeedItem(context),
    );
  }

  Widget _buildListFeedItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FutureBuilder<ListOfRestaurant>(
        future: fetchListOfRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = snapshot.data!.restaurants[index];
                  precacheImage(NetworkImage(restaurant.pictureId), context);
                  return Column(
                    children: [
                      _buildFeedItem(context, restaurant),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  );
                },
              );
            } else {
              return Text("No data available");
            }
          } else {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemCount: snapshot.data?.restaurants.length,
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
        },
      ),
    );
  }

  Widget _buildFeedItem(BuildContext context, Restaurant restaurant) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, FeedDetailPage.route,
            arguments: restaurant);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.white38,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Wrap(
                children: [
                  _buildImageHeader(context, restaurant),
                  _buildDescription(context, restaurant)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageHeader(BuildContext context, Restaurant restaurant) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
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
    );
  }

  Widget _buildDescription(BuildContext context, Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRatingBar(restaurant.rating.toDouble()),
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
        ],
      ),
    );
  }

  Widget _buildRatingBar(double restaurantRating) {
    return Center(
        child: RatingBarWidget(
      rating: restaurantRating,
    ));
  }
}
