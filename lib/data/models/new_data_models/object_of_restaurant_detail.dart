import 'package:bhedhuk_app/data/models/new_data_models/object_customer_review.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_of_restaurant.dart';

class ObjectOfRestaurantDetail extends ObjectOfRestaurant {
  String address;
  List<String> categories;
  Map<String, dynamic> menus;
  List<ObjectOfCustomerReview> listObjectOfCustomerReviews;

  ObjectOfRestaurantDetail({
    required String id,
    required String name,
    required String description,
    required String city,
    required String pictureId,
    required num rating,
    required this.address,
    required this.categories,
    required this.menus,
    required this.listObjectOfCustomerReviews,
  }) : super(
          id: id,
          name: name,
          description: description,
          city: city,
          pictureId: pictureId,
          rating: rating,
        );
}
