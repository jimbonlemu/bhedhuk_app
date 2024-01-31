import 'object_of_api_response.dart';
import 'package:flutter/material.dart';

class ObjectOfCustomerReviewApiResponse extends ObjectOfApiResponse {
  String restaurantId;
  String name;
  String review;
  String date;
  Color backGroundColor;

  ObjectOfCustomerReviewApiResponse({
    required super.error,
    required super.message,
    required this.restaurantId,
    required this.name,
    required this.review,
    required this.date,
    this.backGroundColor = Colors.white,
  });
  factory ObjectOfCustomerReviewApiResponse.fromJson(
      Map<String, dynamic> parsed) {
    return ObjectOfCustomerReviewApiResponse(
      error: parsed['error'] ?? true,
      message: parsed['message'] ?? '',
      restaurantId: parsed['id'] ?? '',
      name: parsed['name'] ?? '',
      review: parsed['review'] ?? '',
      date: parsed['date'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": restaurantId,
      "name": name,
      "review": review,
    };
  }
}
