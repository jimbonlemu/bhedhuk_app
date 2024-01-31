class ObjectOfRestaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  num rating;

  ObjectOfRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory ObjectOfRestaurant.fromJson(Map<String, dynamic> parsed) {
    return ObjectOfRestaurant(
      id: parsed['id'] ?? '',
      name: parsed['name'] ?? '',
      description: parsed['description'] ?? '',
      pictureId: parsed['pictureId'] ?? '',
      city: parsed['city'] ?? '',
      rating: parsed['rating'] ?? 0,
    );
  }
}
