

class Restaurant {
  final String restaurantId,
      restaurantName,
      restaurantDescription,
      restaurantPicture,
      restaurantCity;
  final double restaurantRating;
  final Menus menus;

  Restaurant({
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantDescription,
    required this.restaurantPicture,
    required this.restaurantCity,
    required this.restaurantRating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) => Restaurant(
        restaurantId: restaurant['id'],
        restaurantName: restaurant['name'],
        restaurantDescription: restaurant['description'],
        restaurantPicture: restaurant['pictureId'],
        restaurantCity: restaurant['city'],
        restaurantRating: restaurant['rating'],
        menus: Menus(
          foods: restaurant['menus']['foods'],
          drinks: restaurant['menus']['drinks'],
        ),
      );


  
}

class Menus {
  final List<FoodsAndDrinks> foods;
  final List<FoodsAndDrinks> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> menus) => Menus(
        foods: List<FoodsAndDrinks>.from(
            menus['foods'].map((foods) => FoodsAndDrinks.fromJson(foods))),
        drinks: List<FoodsAndDrinks>.from(
            menus['drinks'].map((drinks) => FoodsAndDrinks.fromJson(drinks))),
      );
}

class FoodsAndDrinks {
  final String name;

  FoodsAndDrinks({
    required this.name,
  });

  factory FoodsAndDrinks.fromJson(Map<String, dynamic> foodsAndDrinks) =>
      FoodsAndDrinks(
        name: foodsAndDrinks['name'],
      );
}


