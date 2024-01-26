import 'dart:convert';
import 'package:bhedhuk_app/data/api/interface_api_service.dart';
import 'package:bhedhuk_app/data/models/new_data_models/list_of_restaurant_object_response.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_customer_review_response.dart';
import 'package:bhedhuk_app/data/models/new_data_models/restaurant_detail_object_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService implements InterfaceApiService {
  static final String _baseUrl = dotenv.env['BASE_URL'] ?? '';
  static const String _getListOfRestaurant = 'list';
  static const String _getDetailOfRestaurant = 'detail/';
  static const String _searchListOfRestaurant = 'search?q=';
  static const String _postReview = 'review';

  @override
  Future<ListOfRestaurantObjectResponse> getListOfRestaurant() async {
    var response = await http.get(Uri.parse(_baseUrl + _getListOfRestaurant));
    if (response.statusCode == 200) {
      return ListOfRestaurantObjectResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Get List Of Restaurant');
    }
  }

  @override
  Future<ObjectOfRestaurantDetailObjectResponse> getRestaurantDetail(
      String restaurantId) async {
    var response = await http
        .get(Uri.parse(_baseUrl + _getDetailOfRestaurant + restaurantId));
    if (response.statusCode == 200) {
      return ObjectOfRestaurantDetailObjectResponse.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception('Failed to Get Restaurant Detail');
    }
  }

  @override
  Future<ListOfRestaurantObjectResponse> searchListOfRestaurant(
      String keyword) async {
    var response =
        await http.get(Uri.parse(_baseUrl + _searchListOfRestaurant + keyword));

    if (response.statusCode == 200) {
      return ListOfRestaurantObjectResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Search List Of Restaurant');
    }
  }

  @override
  Future<ObjectOfCustomerReview> postCustomerReview(
      String restaurantId, String reviewerName, String reviewerComment) async {
    final response = await http.post(
      Uri.parse(_baseUrl + _postReview),
      headers: <String, String>{
        "Content-Type": " application/json ; charset=UTF-8"
      },
      body: jsonEncode(<String, String>{
        "id": restaurantId,
        "name": reviewerName,
        "review": reviewerComment,
      }),
    );

    if (response.statusCode == 200) {
      return ObjectOfCustomerReview.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Post Review');
    }
  }
}
