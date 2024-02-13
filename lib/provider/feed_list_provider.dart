import 'package:bhedhuk_app/data/api/api_service.dart';
import '../data/models/list_of_restaurant_object_api_response.dart';
import 'feed_provider.dart';

class FeedListProvider extends FeedProvider {
  late ListOfRestaurantObjectApiResponse _listOfRestaurantObjectApiResponse;
  ListOfRestaurantObjectApiResponse get getListOfRestaurantObjectApiResponse =>
      _listOfRestaurantObjectApiResponse;
  FeedListProvider() {
    fetchData(
      () async {
        return _listOfRestaurantObjectApiResponse =
            await ApiService().getListOfRestaurant();
      },
    );
  }
}
