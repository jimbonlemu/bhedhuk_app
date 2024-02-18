import 'package:feed_me/data/database/feed_database_service.dart';
import 'package:feed_me/data/models/object_of_restaurant.dart';
import 'package:flutter/foundation.dart';
import '../utils/enum_state.dart';

class FeedDatabaseProvider extends ChangeNotifier {
  final FeedDatabaseService feedDatabaseService;
  ResponseResult _result;

  FeedDatabaseProvider({required this.feedDatabaseService}) : _result = ResponseResult.loading {
    getListFavoritedRestaurant();
  }

  ResponseResult get result => _result;

  String _response = "";
  String get response => _response;

  List<ObjectOfRestaurant> _searchResultFavorited = [];
  List<ObjectOfRestaurant> get searchResultFavorited => _searchResultFavorited;

  List<ObjectOfRestaurant> _listOfFavoritedRestaurant = [];
  List<ObjectOfRestaurant> get listOfFavoritedRestaurant =>
      _listOfFavoritedRestaurant;

  void getListFavoritedRestaurant() async {
    _listOfFavoritedRestaurant =
        await feedDatabaseService.getListFavoritedRestaurant();

    if (_listOfFavoritedRestaurant.isNotEmpty) {
      _result = ResponseResult.hasData;
    } else {
      _result = ResponseResult.noData;
      _response = "No Data";
    }
    notifyListeners();
  }

  void addFavoritedRestaurant(ObjectOfRestaurant objectOfRestaurant) async {
    try {
      await feedDatabaseService.insertFavoritedRestaurant(objectOfRestaurant);

      getListFavoritedRestaurant();
    } catch (e) {
      _result = ResponseResult.error;
      _response = "Error getting data -----> $e";
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String restaurantId) async {
    final favoritedRestaurant =
        await feedDatabaseService.getFavoritedRestaurantById(restaurantId);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavoritedRestaurant(String restaurantId) async {
    try {
      await feedDatabaseService.removeFavoritedRestaurant(restaurantId);
      getListFavoritedRestaurant();
    } catch (e) {
      _result = ResponseResult.error;
      _response = "Error while removing favorited restaurant ----> $e";
      notifyListeners();
    }
  }

  Future<List<ObjectOfRestaurant>> searchRestaurant(String query) async {
    _searchResultFavorited =
        await feedDatabaseService.searchRestaurant(query);
    return _searchResultFavorited;
  }
}
