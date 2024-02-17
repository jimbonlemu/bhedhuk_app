import 'package:feed_me/data/api/api_service.dart';
import 'package:feed_me/data/api/interface_api_service.dart';
import 'package:feed_me/data/models/list_of_restaurant_object_api_response.dart';
import 'package:feed_me/data/models/object_of_restaurant.dart';
import 'package:feed_me/provider/feed_list_provider.dart';
import 'package:feed_me/provider/feed_search_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'feed_list_provider_test.mocks.dart';

class InterfaceServiceTest extends Mock implements InterfaceApiService {}

class ApiServiceTest extends Mock implements ApiService {}

/// Sample API Response to test method get getListOfRestaurant in [ApiService] and [FeedListProvider]
const sampleApiGetListOfRestaurant = {
  "error": false,
  "message": "success",
  "count": 3,
  "restaurants": [
    {
      "id": "uqzwm2m981kfw1e867",
      "name": "Bobby",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
      "pictureId": "19",
      "city": "Ternate",
      "rating": 4.7
    },
    {
      "id": "dy62fuwe6w8kfw1e867",
      "name": "Pangsit Express",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "43",
      "city": "Surabaya",
      "rating": 4.8
    },
    {
      "id": "vfsqv0t48jkfw1e867",
      "name": "Gigitan Makro",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
      "pictureId": "04",
      "city": "Surabaya",
      "rating": 4.9
    }
  ]
};

List<ObjectOfRestaurant> sampleFetchedGetListOfRestaurant = [
  ObjectOfRestaurant(
      id: "uqzwm2m981kfw1e867",
      name: "Bobby",
      description:
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
      pictureId: "19",
      city: "Ternate",
      rating: 4.7),
  ObjectOfRestaurant(
      id: "dy62fuwe6w8kfw1e867",
      name: "Pangsit Express",
      description:
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      pictureId: "43",
      city: "Surabaya",
      rating: 4.8),
  ObjectOfRestaurant(
      id: "vfsqv0t48jkfw1e867",
      name: "Gigitan Makro",
      description:
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
      pictureId: "04",
      city: "Surabaya",
      rating: 4.9),
];

const sampleApiSearchListOfRestaurant = {
  "error": false,
  "founded": 1,
  "restaurants": [
    {
      "id": "dy62fuwe6w8kfw1e867",
      "name": "Pangsit Express",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "43",
      "city": "Surabaya",
      "rating": 4.8
    },
  ]
};

List<ObjectOfRestaurant> sampleFetchedSearchListOfRestaurant = [
  ObjectOfRestaurant(
      id: "dy62fuwe6w8kfw1e867",
      name: "Pangsit Express",
      description:
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      pictureId: "43",
      city: "Surabaya",
      rating: 4.8),
];
@GenerateMocks([InterfaceServiceTest])
@GenerateMocks([ApiServiceTest])
Future<void> main() async {
  await dotenv.load(fileName: ".env");
  group("Restaurant Provider Test", () {
    late FeedListProvider feedListProvider;
    late FeedSearchProvider feedSearchProvider;
    late ApiService apiService;

    setUp(() async {
      apiService = MockApiServiceTest();
      feedListProvider = FeedListProvider(apiService: apiService);
      feedSearchProvider = FeedSearchProvider(apiService: apiService);
    });

    test("fetchAllRestaurant should return list of restaurants", () async {
      when(apiService.getListOfRestaurant()).thenAnswer((_) async =>
          ListOfRestaurantObjectApiResponse.fromJson(sampleApiGetListOfRestaurant));

      await feedListProvider.getAllListOfRestaurant();

      var result = feedListProvider
          .listOfRestaurantObjectApiResponse.listobjectOfRestaurant;
      var expected = sampleFetchedGetListOfRestaurant;

      expect(result.length == expected.length, true);
      expect(result[0].id == expected[0].id, true);
      expect(result[0].name == expected[0].name, true);
      expect(result[0].description == expected[0].description, true);
      expect(result[0].pictureId == expected[0].pictureId, true);
      expect(result[0].city == expected[0].city, true);
      expect(result[0].rating == expected[0].rating, true);
    });

    test("searchRestaurant should return queried restaurants", () async {
      when(apiService.searchListOfRestaurant("Pang")).thenAnswer((_) async =>
          ListOfRestaurantObjectApiResponse.fromJson(sampleApiSearchListOfRestaurant));

      await feedSearchProvider.search("Pang");

      var result = feedSearchProvider
          .listOfRestaurantObjectApiResponse?.listobjectOfRestaurant;
      var expected = sampleFetchedSearchListOfRestaurant;

      expect(result?.length == expected.length, true);
      expect(result?[0].id == expected[0].id, true);
      expect(result?[0].name == expected[0].name, true);
      expect(result?[0].description == expected[0].description, true);
      expect(result?[0].pictureId == expected[0].pictureId, true);
      expect(result?[0].city == expected[0].city, true);
      expect(result?[0].rating == expected[0].rating, true);
    });
  });
}
