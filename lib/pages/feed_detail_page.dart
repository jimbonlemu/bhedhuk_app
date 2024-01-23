import 'package:bhedhuk_app/data/models/restaurant.dart';
import 'package:bhedhuk_app/data/utils/styles.dart';
import 'package:bhedhuk_app/widgets/custom_appbar_widget.dart';
import 'package:bhedhuk_app/widgets/icon_title_widget.dart';
import 'package:bhedhuk_app/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class FeedDetailPage extends StatelessWidget {
  static const route = '/feed_detail_page';
  final Restaurant restaurant;
  const FeedDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppBarWidget(
        disappearWhenScrolled: true,
        image: Image.network(
          restaurant.pictureId,
          fit: BoxFit.cover,
        ),
        imageTitle: Text(
          restaurant.name,
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
                  padding: EdgeInsets.all(50),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLocationAndStar(),
                        const SizedBox(height: 20),
                        _buildAboutRestaurant(),
                        const SizedBox(height: 20),
                        _buildFoodAndDrink(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationAndStar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconTitleWidget(
          restaurant: restaurant,
          icon: Icons.place_outlined,
          text: restaurant.city,
        ),
        IconTitleWidget(
          restaurant: restaurant,
          icon: Icons.star_border,
          text: restaurant.rating.toString(),
        ),
      ],
    );
  }

  Widget _buildAboutRestaurant() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About ${restaurant.name} :', style: bhedhukTextTheme.titleLarge),
        const SizedBox(height: 10),
        Text(restaurant.description),
      ],
    );
  }

  Widget _buildFoodAndDrink() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MenuWidget(
            title: 'Our Foods Menu : ', objectToList: restaurant.getMenuFoods),
        MenuWidget(
            title: 'Our Drinks Menu :', objectToList: restaurant.getMenuDrinks),
      ],
    );
  }
}
