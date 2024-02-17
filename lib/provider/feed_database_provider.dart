import 'package:feed_me/data/database/feed_database_helper.dart';
import 'package:feed_me/data/models/object_of_restaurant.dart';
import 'package:flutter/foundation.dart';

import '../utils/enum_state.dart';

class FeedDatabaseProvider extends ChangeNotifier {
  ResponseResult _result;

  FeedDatabaseProvider() : _result = ResponseResult.loading {
    _getListFavoritedRestaurant();
  }

  ResponseResult get result => _result;

  String _response = "";
  String get response => _response;

  List<ObjectOfRestaurant> _searchResultFavorited = [];
  List<ObjectOfRestaurant> get searchResultFavorited => _searchResultFavorited;

  List<ObjectOfRestaurant> _listOfFavoritedRestaurant = [];
  List<ObjectOfRestaurant> get listOfFavoritedRestaurant =>
      _listOfFavoritedRestaurant;

  void _getListFavoritedRestaurant() async {
    _listOfFavoritedRestaurant =
        await FeedDatabaseService().getListFavoritedRestaurant();
    print('List of Favorited Restaurant: $_listOfFavoritedRestaurant');

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
      await FeedDatabaseService()
          .insertFavoritedRestaurant(objectOfRestaurant)
          .then((value) => print("add resto ${objectOfRestaurant.id}"));
      _getListFavoritedRestaurant();
    } catch (e) {
      _result = ResponseResult.error;
      _response = "Error getting data -----> $e";
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String restaurantId) async {
    final favoritedRestaurant =
        await FeedDatabaseService().getFavoritedRestaurantById(restaurantId);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavoritedRestaurant(String restaurantId) async {
    try {
      await FeedDatabaseService()
          .removeFavoritedRestaurant(restaurantId)
          .then((value) => print("dell resto$restaurantId"));
      _getListFavoritedRestaurant();
    } catch (e) {
      _result = ResponseResult.error;
      _response = "Error while removing favorited restaurant ----> $e";
      notifyListeners();
    }
  }

  Future<List<ObjectOfRestaurant>> searchRestaurant(String query) async {
    _searchResultFavorited =
        await FeedDatabaseService().searchRestaurant(query);
    return _searchResultFavorited;
  }
}
