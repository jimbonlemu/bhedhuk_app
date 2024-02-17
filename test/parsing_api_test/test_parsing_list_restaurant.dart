import 'package:feed_me/data/models/list_of_restaurant_object_api_response.dart';
import 'package:feed_me/data/models/object_of_restaurant.dart';
import 'package:feed_me/provider/feed_list_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:feed_me/data/api/api_service.dart';
import 'package:mockito/annotations.dart';

// Mock ApiService
class MockApiService extends Mock implements ApiService {}

const listApiResponse = {
  "error": false,
  "message": "success",
  "count": 2,
  "restaurants": [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    },
    {
      "id": "s1knt6za9kkfw1e867",
      "name": "Kafe Kita",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "25",
      "city": "Gorontalo",
      "rating": 4
    },
  ]
};

List<ObjectOfRestaurant> testObjectOfRestaurants = [
  ObjectOfRestaurant(
    id: "rqdv5juczeskfw1e867",
    name: "Melting Pot",
    description:
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
    pictureId: "14",
    city: "Medan",
    rating: 4.2,
  ),
  ObjectOfRestaurant(
    id: "s1knt6za9kkfw1e867",
    name: "Kafe Kita",
    description:
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    pictureId: "25",
    city: "Gorontalo",
    rating: 4,
  ),
];

@GenerateMocks([MockApiService])
Future<void> main() async {
  group("Feed Provider Test", () {
    late FeedListProvider feedListProvider;
    late ApiService apiService;

    setUp(() {
      apiService = MockApiService();
      feedListProvider = FeedListProvider(apiService: apiService);
    });
    test("Fetch all resto data", () async {
      when(apiService.getListOfRestaurant()).thenAnswer((_) async =>
          ListOfRestaurantObjectApiResponse.fromJson(listApiResponse));

      await feedListProvider.fetchAllResto();

      var result = feedListProvider
          .listOfRestaurantObjectApiResponse.listobjectOfRestaurant;
      var expected = testObjectOfRestaurants;
      expect(result.length == expected.length, true);
      expect(result[0].id == expected[0].id, true);
      expect(result[0].name == expected[0].name, true);
      expect(result[0].description == expected[0].description, true);
      expect(result[0].pictureId == expected[0].pictureId, true);
      expect(result[0].city == expected[0].city, true);
      expect(result[0].rating == expected[0].rating, true);
    });
  });
}
