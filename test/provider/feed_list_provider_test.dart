import 'package:feed_me/data/api/api_service.dart';
import 'package:feed_me/data/api/interface_api_service.dart';
import 'package:feed_me/data/models/list_of_restaurant_object_api_response.dart';
import 'package:feed_me/data/models/object_of_restaurant.dart';
import 'package:feed_me/provider/feed_list_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'feed_list_provider_test.mocks.dart';

class InterfaceServiceTest extends Mock implements InterfaceApiService {}

class ApiServiceTest extends Mock implements ApiService {}

const apiListResponse = {
  "error": false,
  "message": "success",
  "count": 2,
  "restaurants": [
    {
      "id": "w9pga3s2tubkfw1e867",
      "name": "Bring Your Phone Cafe",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "03",
      "city": "Surabaya",
      "rating": 4.2
    },
    {
      "id": "uewq1zg2zlskfw1e867",
      "name": "Kafein",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "15",
      "city": "Aceh",
      "rating": 4.6
    },
  ]
};

const apiSearchResponse = {
  "error": false,
  "founded": 1,
  "restaurants": [
    {
      "id": "w9pga3s2tubkfw1e867",
      "name": "Bring Your Phone Cafe",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "03",
      "city": "Surabaya",
      "rating": 4.2
    }
  ]
};

List<ObjectOfRestaurant> testRestaurants = [
  ObjectOfRestaurant(
    id: "w9pga3s2tubkfw1e867",
    name: "Bring Your Phone Cafe",
    description:
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    pictureId: "03",
    city: "Surabaya",
    rating: 4.2,
  ),
  ObjectOfRestaurant(
    id: "uewq1zg2zlskfw1e867",
    name: "Kafein",
    description:
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    pictureId: "15",
    city: "Aceh",
    rating: 4.6,
  ),
];

List<ObjectOfRestaurant> testSearchRestaurants = [
  ObjectOfRestaurant(
    id: "w9pga3s2tubkfw1e867",
    name: "Bring Your Phone Cafe",
    description:
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    pictureId: "03",
    city: "Surabaya",
    rating: 4.2,
  ),
];
@GenerateMocks([InterfaceServiceTest])
@GenerateMocks([ApiServiceTest])
Future<void> main() async {
  group("Restaurant Provider Test", () {
    late FeedListProvider feedListProvider;

    late ApiService apiService;

    setUp(() async{
      apiService = MockApiServiceTest();
      feedListProvider = FeedListProvider(apiService: apiService);
    });

    test("fetchAllRestaurant should return list of restaurants", () async {
      when(apiService.getListOfRestaurant()).thenAnswer((_) async =>
          ListOfRestaurantObjectApiResponse.fromJson(apiListResponse));

      await feedListProvider.getAllListOfRestaurant();

      var result = feedListProvider
          .listOfRestaurantObjectApiResponse.listobjectOfRestaurant;
      var expected = testRestaurants;

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
