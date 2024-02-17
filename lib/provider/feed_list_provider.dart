import 'dart:io';

import 'package:feed_me/data/api/api_service.dart';
import 'package:flutter/foundation.dart';
import '../data/models/list_of_restaurant_object_api_response.dart';
import '../utils/enum_state.dart';

class FeedListProvider extends ChangeNotifier {

  FeedListProvider() {
    fetchAllResto();
  }
  late ListOfRestaurantObjectApiResponse _listOfRestaurantObjectApiResponse;
  late ResponseResult _responseResult = ResponseResult.loading;
  String _message = "";

  ResponseResult get responseResult => _responseResult;
  ListOfRestaurantObjectApiResponse get listOfRestaurantObjectApiResponse =>
      _listOfRestaurantObjectApiResponse;
  String get message => _message;

  Future<dynamic> fetchAllResto() async {
    try {
      notifyListeners();

      final resultResto = await ApiService().getListOfRestaurant();
      if (resultResto.listobjectOfRestaurant.isEmpty == true) {
        _responseResult = ResponseResult.noData;
        notifyListeners();
        _message = "All Restaurant Data is Empty";
      } else {
        _responseResult = ResponseResult.hasData;
        notifyListeners();
        return _listOfRestaurantObjectApiResponse = resultResto;
      }
    } on SocketException {
      _responseResult = ResponseResult.error;
      notifyListeners();

      return _message = "Error --> No Internet Connection";
    } catch (e) {
      _responseResult = ResponseResult.error;
      notifyListeners();

      return _message = "Error --> $e";
    }
  }
}
