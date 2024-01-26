import 'dart:convert';
import 'package:bhedhuk_app/data/models/old_data_models/list_restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final String _baseUrl = dotenv.env['BASE_URL'] ?? '';
  static const String _getListOfRestaurant = 'list';
  static const String _getDetailOfRestaurant = 'detail/';
  static const String _getSearchOfRestaurant = 'search?q=';
  static const String _postReview = 'review';
  static const String _getImageSmallResolution =
      'https://restaurant-api.dicoding.dev/images/small/';
  static const String _getImageMediumResolutin =
      'https://restaurant-api.dicoding.dev/images/medium/';
  static const String _getImageLargeResolution =
      'https://restaurant-api.dicoding.dev/images/large/';

  Future<ListOfRestaurant> getListOfRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + _getListOfRestaurant));

    if (response.statusCode == 200) {
      return ListOfRestaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to reach data');
    }
  }
}
