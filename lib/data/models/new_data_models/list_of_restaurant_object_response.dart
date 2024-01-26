import 'package:bhedhuk_app/data/models/new_data_models/object_of_api_response.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_of_restaurant.dart';
import 'package:bhedhuk_app/utils/model_parser.dart';

class ListOfRestaurantObjectResponse extends ObjectOfApiResponse {
  List<ObjectOfRestaurant> listobjectOfRestaurant;
  int count;
  int founded;

  ListOfRestaurantObjectResponse({
    required bool error,
    required String message,
    this.count = 0,
    this.founded = 0,
    required this.listobjectOfRestaurant,
  }) : super(
          error: error,
          message: message,
        );

  factory ListOfRestaurantObjectResponse.fromJson(Map<String, dynamic> json) {
    return ListOfRestaurantObjectResponse(
      error: json['error'] ?? '',
      message: json['message'] ?? '',
      count: json['count'] ?? 0,
      founded: json['founded'] ?? 0,
      listobjectOfRestaurant:
          parser(json['restaurants'], ObjectOfRestaurant.fromJson),
    );
  }
}
