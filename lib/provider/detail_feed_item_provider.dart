import '../data/api/api_service.dart';
import '../data/models/new_data_models/object_of_restaurant_detail.dart';
import 'feed_provider.dart';
import '../data/models/new_data_models/restaurant_detail_object_response.dart';

class DetailFeedProvider extends FeedProvider {
  final ApiService apiService;
  final String restaurantId;

  late ObjectOfRestaurantDetailObjectResponse
      _objectOfRestaurantDetailObjectResponse;
  ObjectOfRestaurantDetailObjectResponse
      get objectOfRestaurantDetailObjectResponse =>
          _objectOfRestaurantDetailObjectResponse;

  DetailFeedProvider({required this.apiService, required this.restaurantId}) {
    _objectOfRestaurantDetailObjectResponse =
        ObjectOfRestaurantDetailObjectResponse(
      error: true,
      message: "",
      objectOfRestaurantDetail: ObjectOfRestaurantDetail(
          id: restaurantId,
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
    fetchData(
      () async {
        return _objectOfRestaurantDetailObjectResponse =
            await apiService.getRestaurantDetail(restaurantId);
      },
    );
  }
}
