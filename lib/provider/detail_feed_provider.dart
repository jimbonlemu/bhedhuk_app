import 'dart:math';

import 'package:flutter/material.dart';

import '../data/api/api_service.dart';
import '../data/models/new_data_models/object_of_restaurant_detail.dart';
import 'feed_provider.dart';
import '../data/models/new_data_models/object_restaurant_detail_api_response.dart';

class DetailFeedProvider extends FeedProvider {
  final ApiService apiService;
  final String restaurantId;

  late ObjectOfRestaurantDetailApiResponse _objectOfRestaurantDetailApiResponse;

  ObjectOfRestaurantDetailApiResponse get objectOfRestaurantDetailApiResponse =>
      _objectOfRestaurantDetailApiResponse;

  DetailFeedProvider({required this.apiService, required this.restaurantId}) {
    _objectOfRestaurantDetailApiResponse = ObjectOfRestaurantDetailApiResponse(
      error: true,
      message: "",
      objectOfRestaurantDetail: ObjectOfRestaurantDetail.empty(),
    );
    getDataOfDetail();
  }
  void getDataOfDetail() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      super.updateResponseResult(ResponseResult.loading);
      fetchData(
        () async {
          var response = await apiService.getRestaurantDetail(restaurantId);
          for (var element in response
              .objectOfRestaurantDetail.listObjectOfCustomerReviews) {
            element.backGroundColor =
                Colors.primaries[Random().nextInt(Colors.primaries.length)];
          }
          return _objectOfRestaurantDetailApiResponse = response;
        },
      );
    });
  }
}
