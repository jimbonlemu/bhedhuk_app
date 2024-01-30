import 'package:bhedhuk_app/data/api/api_service.dart';
import 'package:bhedhuk_app/data/models/new_data_models/object_customer_review_api_response.dart';
import 'package:flutter/material.dart';

class FeedReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  FeedReviewProvider({required this.apiService});

  bool isLoading = false;
  ObjectOfCustomerReviewApiResponse? apiResponse;
  bool isPostCommentSuccessful = false;
  Future<ObjectOfCustomerReviewApiResponse> postComment(
    String restaurantId,
    String name,
    String comment,
  ) async {
    try {
      isLoading = true;
      notifyListeners();
      apiResponse =
          await apiService.postCustomerReview(restaurantId, name, comment);

      if (apiResponse!.error == false) {
        isPostCommentSuccessful = true;
        notifyListeners();
        return apiResponse!;
      } else {
        isPostCommentSuccessful = false;
        notifyListeners();
        throw Exception('Failed to post comment');
      }
    } catch (e) {
      print("ERROR FROM FEED REVIEW PROVIDER ---- >$e");
      throw Exception("EXCEPTION FROM FEED REVIEW PROVIDER ---->  $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // bool isPostCommentLoading = false;
  // bool isPostCommentSuccessful = false;

  // Future<ObjectOfCustomerReviewApiResponse> postCustomerReview(
  //     String restaurantId, String reviewerName, String reviewerComment) async {
  //   isPostCommentLoading = true;
  //   isPostCommentSuccessful = false;
  //   notifyListeners();
  //   try {
  //     final apiResponse = await apiService.postCustomerReview(
  //         restaurantId, reviewerName, reviewerComment);
  //     isPostCommentSuccessful = true;
  //     print("Berhasil KOMENTAR!!!!!!!!!!!!!!!!!!!!!");
  //     print('isPostCommentSuccessful: $isPostCommentSuccessful');
  //     return apiResponse;
  //   } catch (error) {
  //     print("INI GAGALLLL");
  //     print("ERROR FROM PRINT IN FEED REVIEW PROVIDER----->>$error");
  //     throw Exception(
  //         "ERROR FROM EXCEPTION IN FEED REVIEW PROVIDER----->$error");
  //   } finally {
  //     isPostCommentLoading = false;
  //     notifyListeners();
  //   }
  // }
}
