import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../data/models/object_of_restaurant_detail.dart';
import '../data/models/object_restaurant_detail_api_response.dart';
import '../utils/enum_state.dart';

class DetailFeedProvider extends ChangeNotifier {
  final String restaurantId;

  late ResponseResult _responseResult;
  late ObjectOfRestaurantDetailApiResponse _objectOfRestaurantDetailApiResponse;
  String _messageResponse = "";

  ResponseResult get responseResult => _responseResult;
  ObjectOfRestaurantDetailApiResponse get objectOfRestaurantDetailApiResponse =>
      _objectOfRestaurantDetailApiResponse;
  String get messageResponse => _messageResponse;

  DetailFeedProvider({required this.restaurantId}) {
    _objectOfRestaurantDetailApiResponse = ObjectOfRestaurantDetailApiResponse(
      error: true,
      message: "",
      objectOfRestaurantDetail: ObjectOfRestaurantDetail.empty(),
    );
    fetchDataDetail(restaurantId);
  }

  Future<dynamic> fetchDataDetail(String id) async {
    try {
      _responseResult = ResponseResult.loading;
      notifyListeners();
      final apiResponse = await ApiService().getRestaurantDetail(id);
      for (var element
          in apiResponse.objectOfRestaurantDetail.listObjectOfCustomerReviews) {
        element.backGroundColor =
            Colors.primaries[Random().nextInt(Colors.primaries.length)];
      }

      if (apiResponse.objectOfRestaurantDetail.id.isEmpty) {
        _responseResult = ResponseResult.noData;
        _messageResponse = "Data you're trying to call is Empty";
      } else {
        _responseResult = ResponseResult.hasData;
        return _objectOfRestaurantDetailApiResponse = apiResponse;
      }
    } catch (e, stackTrace) {
      _responseResult = ResponseResult.error;
      _messageResponse = "Error FROM DETAIL FEED PROVIDER ---> $e\n$stackTrace";
      if (kDebugMode) {
        print('Caught error: $e');
        print('Stack trace: $stackTrace');
      }
    } finally {
      notifyListeners();
    }
  }
}
