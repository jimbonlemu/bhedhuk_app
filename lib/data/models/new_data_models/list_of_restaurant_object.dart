import 'package:bhedhuk_app/data/models/new_data_models/object_of_api_response.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_of_restaurant.dart';
import 'package:bhedhuk_app/utils/model_parser.dart';

class ListOfRestaurantObjectResponse extends ObjectOfApiResponse {
  List<ObjectOfRestaurant> listobjectOfRestaurant;

  ListOfRestaurantObjectResponse({
    required bool error,
    required String message,
    required this.listobjectOfRestaurant,
  }) : super(
          error: error,
          message: message,
        );

  factory ListOfRestaurantObjectResponse.fromJson(Map<String, dynamic> json) {
    return ListOfRestaurantObjectResponse(
      error: json['error'] ?? '',
      message: json['message'] ?? '',
      listobjectOfRestaurant:
          parser(json['restaurants'], ObjectOfRestaurant.fromJson),
    );
  }
}
