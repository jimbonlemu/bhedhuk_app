import 'dart:math';
import 'dart:ui';
import 'package:bhedhuk_app/data/models/new_data_models/object_of_restaurant.dart';
import 'package:bhedhuk_app/pages/feed_page/feed_detail_page.dart';
import 'package:bhedhuk_app/utils/images.dart';
import 'package:bhedhuk_app/utils/styles.dart';
import 'package:bhedhuk_app/widgets/icon_title_widget.dart';
import 'package:bhedhuk_app/widgets/rating_bar_widget.dart';
import 'package:bhedhuk_app/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';

class FeedItemWidget extends StatelessWidget {
  final ObjectOfRestaurant restaurant;

  const FeedItemWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return _buildFeedItem(context, restaurant);
  }

  Widget _buildFeedItem(BuildContext context, ObjectOfRestaurant restaurant) {
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
                  child: Image.network(Images.instanceImages
                      .getImageSize(restaurant.pictureId, 'medium'))),
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
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FeedDetailPage(
                restaurantId: restaurant.id,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            color: Colors.white38,
            child: Wrap(
              children: [
                _buildImageHeader(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildDescription()),
                    Expanded(
                      child: IconTitleWidget(
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

  Widget _buildImageHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Stack(
          children: [
            Image.network(
              Images.instanceImages.getImageSize(restaurant.pictureId, 'small'),
              color: Colors.amber[200],
              colorBlendMode: BlendMode.darken,
              errorBuilder: (context, error, stackTrace) {
                return _buildShimmerImage();
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return _buildShimmerImage();
              },
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
                  color: whiteColor.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      restaurant.name,
                      style: const TextStyle(color: whiteColor, fontSize: 35),
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

  Widget _buildDescription() {
    var titles = [
      "Overview of the ${restaurant.name} : ",
      "${restaurant.name} at a Glance ! ",
      "About ${restaurant.name} : "
    ];
    var random = Random();
    var title = titles[random.nextInt(titles.length)];

    return Padding(
      padding: const EdgeInsets.only(left: 25, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingBarWidget(
            rating: restaurant.rating.toDouble(),
          ),
          const SizedBox(height: 10),
          Text(
            'Our Rating : ${restaurant.rating}/5',
            style: bhedhukTextTheme.titleMedium,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: bhedhukTextTheme.titleLarge,
          ),
          const SizedBox(height: 5),
          Text(
            restaurant.description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerImage() {
    return CustomWidgetShimmer(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          height: 200,
          color: whiteColor,
        ),
      ),
    );
  }
}
