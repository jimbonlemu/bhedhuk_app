import 'package:bhedhuk_app/data/models/old_data_models/restaurant.dart';
import 'package:bhedhuk_app/utils/styles.dart';
import 'package:bhedhuk_app/widgets/custom_appbar_widget.dart';
import 'package:bhedhuk_app/widgets/icon_title_widget.dart';
import 'package:bhedhuk_app/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class FeedDetailPage extends StatefulWidget {
  static const route = '/feed_detail_page';
  final Restaurant restaurant;
  const FeedDetailPage({super.key, required this.restaurant});

  @override
  State<FeedDetailPage> createState() => _FeedDetailPageState();
}

class _FeedDetailPageState extends State<FeedDetailPage> {
  bool _filledAsFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppBarWidget(
        disappearWhenScrolled: true,
        image: Image.network(
          widget.restaurant.pictureId,
          fit: BoxFit.cover,
        ),
        imageTitle: Text(
          widget.restaurant.name,
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
        Expanded(
          child: IconTitleWidget(
            restaurant: widget.restaurant,
            icon: Icons.place_outlined,
            text: widget.restaurant.city,
          ),
        ),
        Expanded(
          child: IconTitleWidget(
            restaurant: widget.restaurant,
            icon: Icons.star_border,
            text: widget.restaurant.rating.toString(),
          ),
        ),
        Expanded(
          child: IconButton(
              onPressed: () {
                setState(() {
                  _filledAsFavorite = !_filledAsFavorite;
                });
              },
              icon: Icon(
                _filledAsFavorite ? Icons.favorite : Icons.favorite_border,
                color: primaryColor,
              )),
        )
      ],
    );
  }

  Widget _buildAboutRestaurant() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About ${widget.restaurant.name} :',
            style: bhedhukTextTheme.titleLarge),
        const SizedBox(height: 10),
        Text(widget.restaurant.description),
      ],
    );
  }

  Widget _buildFoodAndDrink() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: MenuWidget(
              title: 'Our Foods Menu : ',
              objectToList: widget.restaurant.getMenuFoods),
        ),
        Expanded(
          child: MenuWidget(
              title: 'Our Drinks Menu :',
              objectToList: widget.restaurant.getMenuDrinks),
        ),
      ],
    );
  }
}
