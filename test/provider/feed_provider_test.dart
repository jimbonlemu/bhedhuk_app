import 'package:feed_me/data/api/api_service.dart';
import 'package:feed_me/data/api/interface_api_service.dart';
import 'package:feed_me/data/models/list_of_restaurant_object_api_response.dart';
import 'package:feed_me/data/models/object_customer_review_api_response.dart';
import 'package:feed_me/data/models/object_of_foods_and_drinks.dart';
import 'package:feed_me/data/models/object_of_menus.dart';
import 'package:feed_me/data/models/object_of_restaurant.dart';
import 'package:feed_me/data/models/object_of_restaurant_detail.dart';
import 'package:feed_me/data/models/object_restaurant_detail_api_response.dart';
import 'package:feed_me/provider/detail_feed_provider.dart';
import 'package:feed_me/provider/feed_list_provider.dart';
import 'package:feed_me/provider/feed_search_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'feed_provider_test.mocks.dart';

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

const sampleApiGetRestaurantDetail = {
  "error": false,
  "message": "success",
  "restaurant": {
    "id": "rqdv5juczeskfw1e867",
    "name": "Melting Pot",
    "description":
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
    "city": "Medan",
    "address": "Jln. Pandeglang no 19",
    "pictureId": "14",
    "categories": [
      {"name": "Italia"},
      {"name": "Modern"}
    ],
    "menus": {
      "foods": [
        {"name": "Paket rosemary"},
        {"name": "Toastie salmon"},
        {"name": "Bebek crepes"},
        {"name": "Salad lengkeng"}
      ],
      "drinks": [
        {"name": "Es krim"},
        {"name": "Sirup"},
        {"name": "Jus apel"},
        {"name": "Jus jeruk"},
        {"name": "Coklat panas"},
        {"name": "Air"},
        {"name": "Es kopi"},
        {"name": "Jus alpukat"},
        {"name": "Jus mangga"},
        {"name": "Teh manis"},
        {"name": "Kopi espresso"},
        {"name": "Minuman soda"},
        {"name": "Jus tomat"}
      ]
    },
    "rating": 4.2,
    "customerReviews": [
      {
        "name": "Ahmad",
        "review": "Tidak rekomendasi untuk pelajar!",
        "date": "13 November 2019"
      },
      {
        "name": "John Doe",
        "review": "Great food and service!",
        "date": "17 Februari 2024"
      },
      {"name": "genji", "review": "aaahij shgey", "date": "17 Februari 2024"},
      {
        "name": "Sandhika Galih",
        "review": "Lumayan mahal juga ya :(",
        "date": "17 Februari 2024"
      },
      {
        "name": "Melting Pot",
        "review": "customerReviews",
        "date": "17 Februari 2024"
      }
    ]
  }
};

ObjectOfRestaurantDetail sampleFetchedGetRestaurantDetail =
    ObjectOfRestaurantDetail(
  id: "rqdv5juczeskfw1e867",
  name: "Melting Pot",
  description:
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
  city: "Medan",
  pictureId: "14",
  rating: 4.2,
  address: "Jln. Pandeglang no 19",
  categories: ["Italia", "Modern"],
  menus: [
    ObjectOfMenus(
      foods: [
        ObjectOfFoodsAndDrinks(name: "Paket rosemary"),
        ObjectOfFoodsAndDrinks(name: "Toastie salmon"),
        ObjectOfFoodsAndDrinks(name: "Bebek crepes"),
        ObjectOfFoodsAndDrinks(name: "Salad lengkeng"),
      ],
      drinks: [
        ObjectOfFoodsAndDrinks(name: "Es krim"),
        ObjectOfFoodsAndDrinks(name: "Sirup"),
        ObjectOfFoodsAndDrinks(name: "Jus apel"),
        ObjectOfFoodsAndDrinks(name: "Jus jeruk"),
        ObjectOfFoodsAndDrinks(name: "Coklat panas"),
        ObjectOfFoodsAndDrinks(name: "Air"),
        ObjectOfFoodsAndDrinks(name: "Es kopi"),
        ObjectOfFoodsAndDrinks(name: "Jus alpukat"),
        ObjectOfFoodsAndDrinks(name: "Jus mangga"),
        ObjectOfFoodsAndDrinks(name: "Teh manis"),
        ObjectOfFoodsAndDrinks(name: "Kopi espresso"),
        ObjectOfFoodsAndDrinks(name: "Minuman soda"),
        ObjectOfFoodsAndDrinks(name: "Jus tomat"),
      ],
    ),
  ],
  listObjectOfCustomerReviews: [
    ObjectOfCustomerReviewApiResponse(
      error: false,
      message: "success",
      restaurantId: "rqdv5juczeskfw1e867",
      name: "Ahmad",
      review: "Tidak rekomendasi untuk pelajar!",
      date: "13 November 2019",
    ),
    ObjectOfCustomerReviewApiResponse(
      error: false,
      message: "success",
      restaurantId: "rqdv5juczeskfw1e867",
      name: "John Doe",
      review: "Great food and service!",
      date: "17 Februari 2024",
    ),
    ObjectOfCustomerReviewApiResponse(
        error: false,
        message: "success",
        restaurantId: "rqdv5juczeskfw1e867",
        name: "genji",
        review: "aaahij shgey",
        date: "17 Februari 2024"),
    ObjectOfCustomerReviewApiResponse(
        error: false,
        message: "success",
        restaurantId: "rqdv5juczeskfw1e867",
        name: "Sandhika Galih",
        review: "Lumayan mahal juga ya :(",
        date: "17 Februari 2024"),
    ObjectOfCustomerReviewApiResponse(
        error: false,
        message: "success",
        restaurantId: "rqdv5juczeskfw1e867",
        name: "Melting Pot",
        review: "customerReviews",
        date: "17 Februari 2024"),
  ],
);
@GenerateMocks([InterfaceServiceTest])
@GenerateMocks([ApiServiceTest])
Future<void> main() async {
  await dotenv.load(fileName: ".env");
  group("Restaurant Provider Test", () {
    late FeedListProvider feedListProvider;
    late FeedSearchProvider feedSearchProvider;
    late DetailFeedProvider detailFeedProvider;
    late ApiService apiService;

    setUp(() async {
      apiService = MockApiServiceTest();
      feedListProvider = FeedListProvider(apiService: apiService);
      feedSearchProvider = FeedSearchProvider(apiService: apiService);
      detailFeedProvider =
          DetailFeedProvider(restaurantId: "rqdv5juczeskfw1e867");
    });

    test("getAllListOfRestaurant should return list of restaurants", () async {
      when(apiService.getListOfRestaurant()).thenAnswer((_) async {
        return ListOfRestaurantObjectApiResponse.fromJson(
            sampleApiGetListOfRestaurant);
      });

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

    test("searchListOfRestaurant should return searched restaurants", () async {
      when(apiService.searchListOfRestaurant("Pang")).thenAnswer((_) async {
        return ListOfRestaurantObjectApiResponse.fromJson(
            sampleApiSearchListOfRestaurant);
      });

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

    test("getRestaurantDetail should return the restaurant detail data",
        () async {
      when(apiService.getRestaurantDetail("rqdv5juczeskfw1e867"))
          .thenAnswer((_) async {
        return ObjectOfRestaurantDetailApiResponse.fromJson(
            sampleApiGetRestaurantDetail);
      });

      await detailFeedProvider.fetchDataDetail("rqdv5juczeskfw1e867");

      var result = detailFeedProvider
          .objectOfRestaurantDetailApiResponse.objectOfRestaurantDetail;
      var expected = sampleFetchedGetRestaurantDetail;
      expect(result.id == expected.id, true);
      expect(result.name == expected.name, true);
      expect(result.description == expected.description, true);
      expect(result.pictureId == expected.pictureId, true);
      expect(result.city == expected.city, true);
      expect(result.rating == expected.rating, true);
      expect(result.address == expected.address, true);
      for (int i = 0; i < result.menus.length; i++) {
        for (int j = 0; j < result.menus[i].foods.length; j++) {
          expect(
              result.menus[i].foods[j].name == expected.menus[i].foods[j].name,
              true);
        }
        for (int k = 0; k < result.menus[i].drinks.length; k++) {
          expect(
              result.menus[i].drinks[k].name ==
                  expected.menus[i].drinks[k].name,
              true);
        }
      }
      expect(result.listObjectOfCustomerReviews[0].name == expected.listObjectOfCustomerReviews[0].name, true);
      expect(result.listObjectOfCustomerReviews[0].review == expected.listObjectOfCustomerReviews[0].review, true);
      expect(result.listObjectOfCustomerReviews[0].date == expected.listObjectOfCustomerReviews[0].date, true);
    });
  });
}
