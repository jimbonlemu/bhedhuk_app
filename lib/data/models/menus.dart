import 'package:bhedhuk_app/data/models/foods_and_drinks.dart';
import 'package:bhedhuk_app/data/utils/model_parser.dart';

class Menus {
  final List<FoodsAndDrinks> foods;
  final List<FoodsAndDrinks> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> parsedJson) {
    // List<FoodsAndDrinks> listOfFoods =
    //    ;
    // List<FoodsAndDrinks> listOfDrinks =
    //     ;

    return Menus(
      foods: parser((parsedJson['foods'] as List), FoodsAndDrinks.fromJson),
      drinks: parser((parsedJson['drinks'] as List), FoodsAndDrinks.fromJson),
    );
  }

  // List<String> get foodNames {
  //   return foods.map((foods) => foods.name).toList();
  // }

  // List<String> get drinkNames {
  //   return drinks.map((drinks) => drinks.name).toList();
  // }
}
