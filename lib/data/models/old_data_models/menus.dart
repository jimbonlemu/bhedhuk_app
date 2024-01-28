import 'package:bhedhuk_app/data/models/new_data_models/object_of_foods_and_drinks.dart';
import 'package:bhedhuk_app/utils/model_parser.dart';

class Menus {
  final List<ObjectOfFoodsAndDrinks> foods;
  final List<ObjectOfFoodsAndDrinks> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> parsedJson) {
    return Menus(
      foods: parser(
          (parsedJson['foods'] as List), ObjectOfFoodsAndDrinks.fromJson),
      drinks: parser(
          (parsedJson['drinks'] as List), ObjectOfFoodsAndDrinks.fromJson),
    );
  }
}
