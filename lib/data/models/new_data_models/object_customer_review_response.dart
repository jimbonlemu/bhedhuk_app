import 'package:bhedhuk_app/data/models/new_data_models/object_of_api_response.dart';

class ObjectOfCustomerReview extends ObjectOfApiResponse {
  String restaurantId;
  String name;
  String review;
  String date;

  ObjectOfCustomerReview({
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
  factory ObjectOfCustomerReview.fromJson(Map<String, dynamic> parsed) {
    return ObjectOfCustomerReview(
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
