import 'package:bhedhuk_app/data/api/api_service.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_of_restaurant_detail.dart';
import 'package:flutter/material.dart';
import '../data/models/new_data_models/restaurant_detail_object_response.dart';
import '../utils/response_result.dart';


class DetailFeedProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailFeedProvider({required this.apiService, required this.id}) {
    _objectOfRestaurantDetailObjectResponse =
        ObjectOfRestaurantDetailObjectResponse(
      error: true,
      message: "",
      objectOfRestaurantDetail: ObjectOfRestaurantDetail(
          id: id,
          name: "",
          description: "",
          city: "",
          pictureId: "",
          rating: 0,
          address: "",
          categories: [],
          menus: [],
          listObjectOfCustomerReviews: []),
    );
    _fetchDetailRestaurant(id);
  }

  late ObjectOfRestaurantDetailObjectResponse
      _objectOfRestaurantDetailObjectResponse;

  late ResponseResult _responseResult;

  String _messageResponse = "";

  ObjectOfRestaurantDetailObjectResponse
      get objectOfRestaurantDetailObjectResponse =>
          _objectOfRestaurantDetailObjectResponse;

  ResponseResult get responseResult => _responseResult;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _responseResult = ResponseResult.loading;
      notifyListeners();
      final apiResponse = await apiService.getRestaurantDetail(id);

      if (apiResponse.objectOfRestaurantDetail.id.isEmpty) {
        _responseResult = ResponseResult.noData;
        _messageResponse = 'Restaurant ID is Empty';
        notifyListeners();
        return _messageResponse;
      } else {
        _responseResult = ResponseResult.hasData;
        notifyListeners();
        return _objectOfRestaurantDetailObjectResponse = apiResponse;
      }
    } catch (e) {
      _responseResult = ResponseResult.error;
      _messageResponse = 'Error --> $e';
      notifyListeners();
      print(e);
      return _messageResponse;
    }
  }
}
