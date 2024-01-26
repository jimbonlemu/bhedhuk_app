import 'package:bhedhuk_app/data/models/new_data_models/object_of_api_response.dart';

class ObjectOfCustomerReview extends ObjectOfApiResponse {
  String restaurantId;
  String name;
  String review;

  ObjectOfCustomerReview({
    required this.restaurantId,
    required this.name,
    required this.review,
    required bool error,
    required String message,
  }) : super(
          error: error,
          message: message,
        );
}
