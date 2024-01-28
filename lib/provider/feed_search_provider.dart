import 'package:bhedhuk_app/provider/feed_provider.dart' show ResponseResult;
import 'package:flutter/material.dart';

import '../data/api/api_service.dart';
import '../data/models/new_data_models/list_of_restaurant_object_response.dart';

class FeedSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  ListOfRestaurantObjectResponse? listOfRestaurantObjectResponse;
  ResponseResult _responseResult = ResponseResult.loading;

  bool isLoading = false;

  FeedSearchProvider({required this.apiService});

  Future<void> search(String keyword) async {
    isLoading = true;
    _responseResult = ResponseResult.loading; 

    notifyListeners();

    try {
      listOfRestaurantObjectResponse =
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

// class SearchProvider extends ChangeNotifier {
//   String _keyword = '';
//   final List<String> _data = [
//     'Apple',
//     'Banana',
//     'Cherry',
//     'Date',
//     'Elderberry',
//   ];
//   List<String> _searchResults = [];

//   List<String> get searchResults => _searchResults;

//   void onSearchButtonPressed() {
//     _searchResults = _data
//         .where((item) => item.toLowerCase().contains(_keyword.toLowerCase()))
//         .toList();
//     notifyListeners();
//   }

//   void clearSearchResults() {
//     _searchResults = [];
//     notifyListeners();
//   }

//   void updateKeyword(String keyword) {
//     if (keyword.isEmpty) {
//       return clearSearchResults();
//     } else {
//       _keyword = keyword;
//       notifyListeners();
//     }
//   }
// }
