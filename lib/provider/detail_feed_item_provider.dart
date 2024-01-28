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
        return _objectOfRestaurantDetailApiResponse =
            await apiService.getRestaurantDetail(restaurantId);
      },
    );
  }
}
