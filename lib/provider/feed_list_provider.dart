import 'package:bhedhuk_app/data/api/api_service.dart';
import 'package:bhedhuk_app/data/models/new_data_models/list_of_restaurant_object_api_response.dart';
import 'feed_provider.dart';

class FeedListProvider extends FeedProvider {
  final ApiService apiService;

  late ListOfRestaurantObjectApiResponse _listOfRestaurantObjectApiResponse;
  ListOfRestaurantObjectApiResponse get getListOfRestaurantObjectApiResponse =>
      _listOfRestaurantObjectApiResponse;
  FeedListProvider({required this.apiService}) {
    fetchData(
      () async {
        return _listOfRestaurantObjectApiResponse =
            await apiService.getListOfRestaurant();
      },
    );
  }
}
