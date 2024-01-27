import 'package:bhedhuk_app/data/models/new_data_models/foods_and_drinks.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_customer_review_response.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_of_menus.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_of_restaurant.dart';
import 'package:bhedhuk_app/utils/model_parser.dart';

class ObjectOfRestaurantDetail extends ObjectOfRestaurant {
  String address;
  List<String> categories;
  List<ObjectOfMenus> menus;
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
    var menusJson = parsed['menus'] as Map<String, dynamic>;
    ObjectOfMenus objectOfmenus = ObjectOfMenus.fromJson(menusJson);
    return ObjectOfRestaurantDetail(
      id: parsed['id'] ?? '',
      name: parsed['name'] ?? '',
      description: parsed['description'] ?? '',
      city: parsed['city'] ?? '',
      pictureId: parsed['pictureId'] ?? '',
      rating: parsed['rating'] ?? 0,
      address: parsed['address'] ?? '',
      categories: parsed['categories'] != null
          ? List<String>.from(parsed['categories'].map((x) => x['name']))
          : [],
      menus: [objectOfmenus],
      listObjectOfCustomerReviews:
          parser(parsed['customerReviews'], ObjectOfCustomerReview.fromJson),
    );
  }

  List<dynamic> get getMenuFoods =>
      _getMenuItems(menus, (menus) => menus.foods);

  List<dynamic> get getMenuDrinks =>
      _getMenuItems(menus, (menus) => menus.drinks);

  List<dynamic> _getMenuItems(List<ObjectOfMenus> menus,
      List<ObjectOfFoodsAndDrinks> Function(ObjectOfMenus) getter) {
    return menus.expand(getter).map((item) => item.name).toList();
  }
}
