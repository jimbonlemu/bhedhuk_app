import 'package:flutter/material.dart';

enum ResponseResult { loading, noData, hasData, error }

abstract class FeedProvider extends ChangeNotifier {
  late ResponseResult _responseResult;
  String _messageResponse = "";

  String get messageResponse => _messageResponse;
  ResponseResult get responseResult => _responseResult;

  FeedProvider() {
    _responseResult = ResponseResult.loading;
  }

  Future<dynamic> fetchData(Future<dynamic> Function() apiService) async {
    try {
      _responseResult = ResponseResult.loading;
      notifyListeners();
      final apiResponse = await apiService();

      if (apiResponse == null) {
        _responseResult = ResponseResult.noData;
        _messageResponse = "Data you're trying to call is Empty";
      } else {
        _responseResult = ResponseResult.hasData;
        return apiResponse;
      }
    } catch (e, stackTrace) {
      _responseResult = ResponseResult.error;
      _messageResponse = "Error FROM FEED PROVIDER ---> $e\n$stackTrace";
    } finally {
      notifyListeners();
    }
    return throw Exception("FROM FEED PROVIDER ---->  $_messageResponse");
  }

  void updateResponseResult(ResponseResult result) {
    _responseResult = result;
    notifyListeners();
  }
}
