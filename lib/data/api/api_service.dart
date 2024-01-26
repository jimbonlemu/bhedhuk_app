import 'dart:convert';
import 'package:bhedhuk_app/data/models/new_data_models/list_of_restaurant_object_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final String _baseUrl = dotenv.env['BASE_URL'] ?? '';
  static const String _getListOfRestaurant = 'list';
  // static const String _getDetailOfRestaurant = 'detail/';
  // static const String _getSearchOfRestaurant = 'search?q=';
  // static const String _postReview = 'review';

  Future<ListOfRestaurantObjectResponse> getListOfRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + _getListOfRestaurant));
    if (response.statusCode == 200) {
      return ListOfRestaurantObjectResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to reach data');
    }
  }
}
