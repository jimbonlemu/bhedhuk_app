import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../data/models/new_data_models/list_of_restaurant_object_api_response.dart';

class FeedSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  ListOfRestaurantObjectApiResponse? listOfRestaurantObjectApiResponse;

  bool isTriggeredToLoading = false;

  TextEditingController searchController = TextEditingController();
  FeedSearchProvider({required this.apiService});

  Future<void> search(String keyword) async {
    isTriggeredToLoading = true;
    notifyListeners();
    try {
      listOfRestaurantObjectApiResponse =
          await apiService.searchListOfRestaurant(keyword);
    } catch (e) {
      print("$e");
    }
    isTriggeredToLoading = false;
    notifyListeners();
  }
}
