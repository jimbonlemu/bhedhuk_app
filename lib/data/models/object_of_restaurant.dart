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

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };

  @override
  String toString() {
    return 'ObjectOfRestaurant {id: $id, name: $name, description: $description, pictureId: $pictureId, city: $city, rating: $rating}';
  }
}
