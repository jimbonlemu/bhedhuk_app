import 'object_of_api_response.dart';
import 'object_of_restaurant_detail.dart';

class ObjectOfRestaurantDetailApiResponse extends ObjectOfApiResponse {
  ObjectOfRestaurantDetail objectOfRestaurantDetail;

  ObjectOfRestaurantDetailApiResponse({
    required super.error,
    required super.message,
    required this.objectOfRestaurantDetail,
  });

  factory ObjectOfRestaurantDetailApiResponse.fromJson(
      Map<String, dynamic> parsed) {
    return ObjectOfRestaurantDetailApiResponse(
      error: parsed['error'],
      message: parsed['message'],
      objectOfRestaurantDetail: parsed['restaurant'] != null
          ? ObjectOfRestaurantDetail.fromJson(parsed['restaurant'])
          : ObjectOfRestaurantDetail.empty(),
    );
  }
}
