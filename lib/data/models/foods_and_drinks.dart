class FoodsAndDrinks {
  final String name;

  FoodsAndDrinks({
    required this.name,
  });

  factory FoodsAndDrinks.fromJson(Map<String, dynamic> parsedJson) {
    return FoodsAndDrinks(name: parsedJson['name']);
  }
}
