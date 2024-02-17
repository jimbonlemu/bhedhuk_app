import 'dart:math';
import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../data/models/object_of_restaurant_detail.dart';
import '../data/models/object_restaurant_detail_api_response.dart';
import '../utils/enum_state.dart';
import 'feed_provider.dart';

class DetailFeedProvider extends FeedProvider {
  final String restaurantId;

  late ObjectOfRestaurantDetailApiResponse _objectOfRestaurantDetailApiResponse;

  ObjectOfRestaurantDetailApiResponse get objectOfRestaurantDetailApiResponse =>
      _objectOfRestaurantDetailApiResponse;

  DetailFeedProvider({required this.restaurantId}) {
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
          var response = await ApiService().getRestaurantDetail(restaurantId);
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
