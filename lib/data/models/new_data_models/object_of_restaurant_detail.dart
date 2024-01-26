import 'package:bhedhuk_app/data/models/new_data_models/object_customer_review_response.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_of_restaurant.dart';
import 'package:bhedhuk_app/utils/model_parser.dart';

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

  factory ObjectOfRestaurantDetail.fromJson(Map<String, dynamic> parsed) {
    return ObjectOfRestaurantDetail(
      id: parsed['id']??'',
      name: parsed['name']??'',
      description: parsed['description']??'',
      city: parsed['city']??'',
      pictureId: parsed['pictureId']??'',
      rating: parsed['rating']??0,
      address: parsed['address']??'',
      categories: parsed['categories']??'',
      menus: {
        'foods': parser(parsed['menus']['foods'], (parsing) => parsing['name']),
            // List<String>.from(parsed['menus']['foods'].map((x) => x['name'])),
        'drinks':parser(parsed['menus']['drinks'], (parsing) => parsing['name']),
            // List<String>.from(parsed['menus']['drinks'].map((x) => x['name'])),
      },
      listObjectOfCustomerReviews: parser(parsed['customerReviews'], ObjectOfCustomerReview.fromJson),
      // List<ObjectOfCustomerReview>.from(
      //     parsed['customerReviews']
      //         .map((x) => ObjectOfCustomerReview.fromJson(x))),
    );
  }
}
