import 'package:bhedhuk_app/data/models/new_data_models/list_of_restaurant_object_api_response.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_customer_review_api_response.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_restaurant_detail_api_response.dart';

abstract class InterfaceApiService {
  Future<ListOfRestaurantObjectApiResponse> getListOfRestaurant();
  Future<ObjectOfRestaurantDetailApiResponse> getRestaurantDetail(
      String restaurantId);
  Future<ListOfRestaurantObjectApiResponse> searchListOfRestaurant(
      String keyword);
  Future<ObjectOfCustomerReviewApiResponse> postCustomerReview(
      String restaurantId, String reviewerName, String reviewComment);
}
