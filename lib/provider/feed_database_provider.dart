import 'package:bhedhuk_app/data/database/feed_database_helper.dart';
import 'package:bhedhuk_app/data/models/object_of_restaurant.dart';
import 'package:bhedhuk_app/provider/feed_provider.dart';
import 'package:flutter/foundation.dart';

class FeedDatabaseProvider extends ChangeNotifier {
  final FeedDatabase feedDatabaseHelper;
  ResponseResult _result;
  FeedDatabaseProvider({required this.feedDatabaseHelper})
      : _result = ResponseResult.loading {
    _getListFavoritedRestaurant();
  }

  ResponseResult get result => _result;

  String _response = "";
  String get response => _response;

  List<ObjectOfRestaurant> _listOfFavoritedRestaurant = [];
  List<ObjectOfRestaurant> get listOfFavoritedRestaurant =>
      _listOfFavoritedRestaurant;

  void _getListFavoritedRestaurant() async {
    _listOfFavoritedRestaurant =
        await feedDatabaseHelper.getListFavoritedRestaurant();
    print(
        'List of Favorited Restaurant: $_listOfFavoritedRestaurant');

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
      await feedDatabaseHelper
          .insertFavoritedRestaurant(objectOfRestaurant)
          .then((value) => print("add resto " + objectOfRestaurant.id));
      _getListFavoritedRestaurant();
    } catch (e) {
      _result = ResponseResult.error;
      _response = "Error getting data -----> $e";
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String restaurantId) async {
    final favoritedRestaurant =
        await feedDatabaseHelper.getFavoritedRestaurantById(restaurantId);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavoritedRestaurant(String restaurantId) async {
    try {
      await feedDatabaseHelper
          .removeFavoritedRestaurant(restaurantId)
          .then((value) => print("dell resto" + restaurantId));
      _getListFavoritedRestaurant();
    } catch (e) {
      _result = ResponseResult.error;
      _response = "Error while removing favorited restaurant ----> $e";
      notifyListeners();
    }
  }
}
