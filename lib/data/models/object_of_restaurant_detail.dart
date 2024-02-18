import 'object_of_foods_and_drinks.dart';
import 'object_customer_review_api_response.dart';
import 'object_of_menus.dart';
import 'object_of_restaurant.dart';
import '../../utils/model_parser.dart';

class ObjectOfRestaurantDetail extends ObjectOfRestaurant {
  String address;
  List<String> categories;
  List<ObjectOfMenus> menus;
  List<ObjectOfCustomerReviewApiResponse> listObjectOfCustomerReviews;

  ObjectOfRestaurantDetail({
    required super.id,
    required super.name,
    required super.description,
    required super.city,
    required super.pictureId,
    required super.rating,
    required this.address,
    required this.categories,
    required this.menus,
    required this.listObjectOfCustomerReviews,
  });

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
      listObjectOfCustomerReviews: parser(parsed['customerReviews'],
          ObjectOfCustomerReviewApiResponse.fromJson),
    );
  }

  factory ObjectOfRestaurantDetail.empty() {
    return ObjectOfRestaurantDetail(
      id: "",
      name: "",
      description: "",
      city: "",
      pictureId: "",
      rating: 0,
      address: "",
      categories: [],
      menus: [],
      listObjectOfCustomerReviews: [],
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
