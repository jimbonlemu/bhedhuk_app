import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../data/models/list_of_restaurant_object_api_response.dart';

class FeedSearchProvider extends ChangeNotifier {
  ApiService apiService;
  ListOfRestaurantObjectApiResponse? listOfRestaurantObjectApiResponse;

  bool isTriggeredToLoading = false;
  FeedSearchProvider({required this.apiService}) {
    apiService = ApiService();
  }
  Future<void> search(String keyword) async {
    isTriggeredToLoading = true;
    notifyListeners();
    try {
      listOfRestaurantObjectApiResponse =
          await apiService.searchListOfRestaurant(keyword);
    } catch (e) {
      print("PRINT FROM FEED SEARCH PROVIDER ----> \n $e");
      throw Exception("EXCEPTION FROM FEED SEARCH PROVIDER --->\n $e");
    }
    isTriggeredToLoading = false;
    notifyListeners();
  }

  void clearSearch() {
    listOfRestaurantObjectApiResponse = null;
    notifyListeners();
  }
}
