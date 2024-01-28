import 'package:bhedhuk_app/provider/feed_provider.dart';
import 'package:flutter/material.dart';

import '../data/api/api_service.dart';
import '../data/models/new_data_models/list_of_restaurant_object_api_response.dart';

class FeedSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  ListOfRestaurantObjectApiResponse? listOfRestaurantObjectApiResponse;
  ResponseResult _responseResult = ResponseResult.loading;
  bool isLoading = false;

  TextEditingController searchController = TextEditingController();
  FeedSearchProvider({required this.apiService});

  Future<void> search(String keyword) async {
    isLoading = true;
    _responseResult = ResponseResult.loading;

    notifyListeners();

    try {
      listOfRestaurantObjectApiResponse =
          await apiService.searchListOfRestaurant(keyword);
      _responseResult = ResponseResult.hasData;
    } catch (e) {
      print("$e");
      _responseResult = ResponseResult.error;
    }

    isLoading = false;
    notifyListeners();
  }

  ResponseResult get responseResult => _responseResult;
}
