import 'package:bhedhuk_app/data/models/new_data_models/list_of_restaurant_object_response.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_customer_review_response.dart';
import 'package:bhedhuk_app/data/models/new_data_models/restaurant_detail_object_response.dart';

abstract class InterfaceApiService {
  Future<ListOfRestaurantObjectResponse> getListOfRestaurant();
  Future<ObjectOfRestaurantDetailObjectResponse> getRestaurantDetail(
      String restaurantId);
  Future<ListOfRestaurantObjectResponse> searchListOfRestaurant(String keyword);
  Future<ObjectOfCustomerReview> postCustomerReview(
      String restaurantId, String reviewerName, String reviewComment);
}
