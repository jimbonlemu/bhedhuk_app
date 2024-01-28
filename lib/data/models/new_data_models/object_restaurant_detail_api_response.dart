import 'package:bhedhuk_app/data/models/new_data_models/object_of_api_response.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_of_restaurant_detail.dart';

class ObjectOfRestaurantDetailApiResponse extends ObjectOfApiResponse {
  ObjectOfRestaurantDetail objectOfRestaurantDetail;

  ObjectOfRestaurantDetailApiResponse({
    required bool error,
    required String message,
    required this.objectOfRestaurantDetail,
  }) : super(
          error: error,
          message: message,
        );

  factory ObjectOfRestaurantDetailApiResponse.fromJson(
      Map<String, dynamic> parsed) {
    return ObjectOfRestaurantDetailApiResponse(
      error: parsed['error'],
      message: parsed['message'],
      objectOfRestaurantDetail:
          ObjectOfRestaurantDetail.fromJson(parsed['restaurant']),
    );
  }
}
