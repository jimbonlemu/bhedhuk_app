import 'dart:io';
import '../data/api/api_service.dart';
import 'package:flutter/foundation.dart';
import '../data/models/list_of_restaurant_object_api_response.dart';
import '../utils/enum_state.dart';

class FeedListProvider extends ChangeNotifier {
  final ApiService apiService;

  FeedListProvider({required this.apiService}) {
    getAllListOfRestaurant();
  }

  late ListOfRestaurantObjectApiResponse _listOfRestaurantObjectApiResponse;
  late ResponseResult _responseResult = ResponseResult.loading;
  String _message = "";

  ResponseResult get responseResult => _responseResult;
  ListOfRestaurantObjectApiResponse get listOfRestaurantObjectApiResponse =>
      _listOfRestaurantObjectApiResponse;
  String get message => _message;

  Future<void> getAllListOfRestaurant() async {
    try {
      final resultResto = await apiService.getListOfRestaurant();
      if (resultResto.listobjectOfRestaurant.isEmpty) {
        _responseResult = ResponseResult.noData;
        _message = "All Restaurant Data is Empty";
      } else {
        _responseResult = ResponseResult.hasData;
        _listOfRestaurantObjectApiResponse = resultResto;
      }
    } on SocketException {
      _responseResult = ResponseResult.error;
      _message = "Error --> No Internet Connection";
    } catch (e) {
      _responseResult = ResponseResult.error;
      _message = "Error --> $e";
    } finally {
      notifyListeners();
    }
  }
}
