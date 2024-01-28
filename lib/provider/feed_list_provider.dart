import 'package:bhedhuk_app/data/api/api_service.dart';
import 'package:bhedhuk_app/data/models/new_data_models/list_of_restaurant_object_response.dart';
import 'feed_provider.dart';

class FeedListProvider extends FeedProvider {
  final ApiService apiService;

  late ListOfRestaurantObjectResponse _listOfRestaurantObjectResponse;
  ListOfRestaurantObjectResponse get getListOfRestaurantObjectResponse =>
      _listOfRestaurantObjectResponse;
  FeedListProvider({required this.apiService}) {
    fetchData(
      () async {
        return _listOfRestaurantObjectResponse =
            await apiService.getListOfRestaurant();
      },
    );
  }
}

// class FeedListProvider extends ChangeNotifier {
//   final ApiService apiService;

//   FeedListProvider({
//     required this.apiService,
//   }) {
//     _fetchListOfRestaurant();
//   }

//   late ListOfRestaurantObjectResponse _listOfRestaurantObjectResponse;

//   late ResponseResult _response;

//   String _messageResponse = '';

//   String get messageResponse => _messageResponse;

//   ListOfRestaurantObjectResponse get getListOfRestaurantObjectResponse =>
//       _listOfRestaurantObjectResponse;

//   ResponseResult get responseResult => _response;

//   Future<dynamic> _fetchListOfRestaurant() async {
//     try {
//       _response = ResponseResult.loading;
//       notifyListeners();
//       final apiResponse = await apiService.getListOfRestaurant();

//       if (apiResponse.listobjectOfRestaurant.isEmpty) {
//         _response = ResponseResult.noData;
//         notifyListeners();
//         return _messageResponse = 'Data is Empty';
//       } else {
//         _response = ResponseResult.hasData;
//         notifyListeners();
//         return _listOfRestaurantObjectResponse = apiResponse;
//       }
//     } catch (e) {
//       _response = ResponseResult.error;
//       notifyListeners();
//       return _messageResponse = 'Error --> $e';
//     }
//   }
// }
