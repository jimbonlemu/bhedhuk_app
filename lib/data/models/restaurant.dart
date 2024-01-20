import 'package:bhedhuk_app/data/models/foods_and_drinks.dart';
import 'package:bhedhuk_app/data/models/menus.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;
  final List<Menus> menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> parsedJson) {
    var menusJson = parsedJson['menus'] as Map<String, dynamic>;
    Menus menus = Menus.fromJson(menusJson);
    return Restaurant(
      id: parsedJson['id'] ?? '',
      name: parsedJson['name'] ?? '',
      description: parsedJson['description'] ?? '',
      pictureId: parsedJson['pictureId'] ?? '',
      city: parsedJson['city'] ?? '',
      rating: parsedJson['rating'] ?? 0,
      menus: [menus],
    );
  }

  String get getId => id;

  String get getName => name;

  String get getPictureId => pictureId;

  num get getRating => rating;

  String get getMenuFoods => _getMenuItems(menus, (menus) => menus.foods);

  String get getMenuDrinks => _getMenuItems(menus, (menus) => menus.drinks);

  String _getMenuItems(
      List<Menus> menus, List<FoodsAndDrinks> Function(Menus) getter) {
    return menus.expand(getter).map((item) => item.name).join('\n');
  }
}
