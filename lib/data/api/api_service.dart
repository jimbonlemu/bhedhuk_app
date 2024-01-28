import 'dart:convert';
import 'package:bhedhuk_app/data/api/interface_api_service.dart';
import 'package:bhedhuk_app/data/models/new_data_models/list_of_restaurant_object_api_response.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_customer_review_api_response.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_restaurant_detail_api_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService implements InterfaceApiService {
  static final String _baseUrl = dotenv.env['BASE_URL'] ?? '';
  static const String _getListOfRestaurant = 'list';
  static const String _getDetailOfRestaurant = 'detail/';
  static const String _searchListOfRestaurant = 'search?q=';
  static const String _postReview = 'review';

  Future<dynamic> _get(String url, Function fromJson) async {
    var response = await http.get(Uri.parse(_baseUrl + url));
    if (response.statusCode == 200) {
      return fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error ----');
    }
  }

  @override
  Future<ListOfRestaurantObjectApiResponse> getListOfRestaurant() async {
    return await _get(
        _getListOfRestaurant, ListOfRestaurantObjectApiResponse.fromJson);
  }

  @override
  Future<ObjectOfRestaurantDetailApiResponse> getRestaurantDetail(
      String restaurantId) async {
    return await _get(_getDetailOfRestaurant + restaurantId,
        ObjectOfRestaurantDetailApiResponse.fromJson);
  }

  @override
  Future<ListOfRestaurantObjectApiResponse> searchListOfRestaurant(
      String keyword) async {
    return await _get(_searchListOfRestaurant + keyword,
        ListOfRestaurantObjectApiResponse.fromJson);
  }

  @override
  Future<ObjectOfCustomerReviewApiResponse> postCustomerReview(
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
      return ObjectOfCustomerReviewApiResponse.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception('Failed to Post Review');
    }
  }
}
