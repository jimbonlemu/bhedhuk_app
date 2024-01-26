import 'package:bhedhuk_app/data/models/new_data_models/object_of_api_response.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_of_restaurant.dart';
import 'package:bhedhuk_app/utils/model_parser.dart';

class ListOfRestaurantObject extends ObjectOfApiResponse {
  List<ObjectOfRestaurant> objectOfRestaurant;

  ListOfRestaurantObject({
    required bool error,
    required String message,
    required this.objectOfRestaurant,
  }) : super(
          error: error,
          message: message,
        );

  factory ListOfRestaurantObject.fromJson(Map<String, dynamic> json) {
    return ListOfRestaurantObject(
      error: json['error'],
      message: json['message'],
      objectOfRestaurant:
          parser(json['restaurants'], ObjectOfRestaurant.fromJson),
    );
  }
}
