import 'package:feed_me/data/api/api_service.dart';
import 'package:flutter/material.dart';

import '../data/models/object_customer_review_api_response.dart';

class FeedReviewProvider extends ChangeNotifier {
  ApiService apiService;
  FeedReviewProvider({required this.apiService});

  bool isLoading = false;
  ObjectOfCustomerReviewApiResponse? objectOfCustomerReviewApiResponse;
  bool isPostCommentSuccessful = false;
  Future<ObjectOfCustomerReviewApiResponse> postComment(
    String restaurantId,
    String name,
    String comment,
  ) async {
    try {
      isLoading = true;
      notifyListeners();
      objectOfCustomerReviewApiResponse =
          await apiService.postCustomerReview(restaurantId, name, comment);

      if (objectOfCustomerReviewApiResponse!.error == false) {
        isPostCommentSuccessful = true;
        notifyListeners();
        return objectOfCustomerReviewApiResponse!;
      } else {
        isPostCommentSuccessful = false;
        notifyListeners();
        throw Exception('Failed to post comment');
      }
    } catch (e) {
      print("ERROR FROM FEED REVIEW PROVIDER ---- >$e ");
      throw Exception("EXCEPTION FROM FEED REVIEW PROVIDER ---->  $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
