import 'package:bhedhuk_app/data/models/new_data_models/object_of_api_response.dart';

class ObjectOfCustomerReviewApiResponse extends ObjectOfApiResponse {
  String restaurantId;
  String name;
  String review;
  String date;

  ObjectOfCustomerReviewApiResponse({
    required bool error,
    required String message,
    required this.restaurantId,
    required this.name,
    required this.review,
    required this.date,
  }) : super(
          error: error,
          message: message,
        );
  factory ObjectOfCustomerReviewApiResponse.fromJson(
      Map<String, dynamic> parsed) {
    return ObjectOfCustomerReviewApiResponse(
      error: parsed['error'] ?? true,
      message: parsed['message'] ?? '',
      restaurantId: parsed['id'] ?? '',
      name: parsed['name'] ?? '',
      review: parsed['review'] ?? '',
      date: parsed['date'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": restaurantId,
      "name": name,
      "review": review,
    };
  }
}
