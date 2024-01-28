class ObjectOfFoodsAndDrinks {
  final String name;

  ObjectOfFoodsAndDrinks({
    required this.name,
  });

  factory ObjectOfFoodsAndDrinks.fromJson(Map<String, dynamic> parsedJson) {
    return ObjectOfFoodsAndDrinks(name: parsedJson['name'] ?? '');
  }
}
