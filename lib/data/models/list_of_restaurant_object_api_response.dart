import 'object_of_api_response.dart';
import 'object_of_restaurant.dart';
import 'package:feed_me/utils/model_parser.dart';

class ListOfRestaurantObjectApiResponse extends ObjectOfApiResponse {
  List<ObjectOfRestaurant> listobjectOfRestaurant;
  int count;
  int founded = 0;

  ListOfRestaurantObjectApiResponse({
    required super.error,
    required super.message,
    this.count = 0,
    this.founded = 0,
    required this.listobjectOfRestaurant,
  });

  factory ListOfRestaurantObjectApiResponse.fromJson(
      Map<String, dynamic> json) {
    return ListOfRestaurantObjectApiResponse(
      error: json['error'] ?? true,
      message: json['message'] ?? '',
      count: json['count'] ?? 0,
      founded: json['founded'] ?? 0,
      listobjectOfRestaurant:
          parser(json['restaurants'], ObjectOfRestaurant.fromJson),
    );
  }
}
