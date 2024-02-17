import 'object_of_foods_and_drinks.dart';
import 'package:feed_me/utils/model_parser.dart';

class ObjectOfMenus {
  final List<ObjectOfFoodsAndDrinks> foods;
  final List<ObjectOfFoodsAndDrinks> drinks;

  ObjectOfMenus({
    required this.foods,
    required this.drinks,
  });

  factory ObjectOfMenus.fromJson(Map<String, dynamic> parsedJson) {
    return ObjectOfMenus(
      foods: parser(
          (parsedJson['foods'] as List), ObjectOfFoodsAndDrinks.fromJson),
      drinks: parser(
          (parsedJson['drinks'] as List), ObjectOfFoodsAndDrinks.fromJson),
    );
  }
}
