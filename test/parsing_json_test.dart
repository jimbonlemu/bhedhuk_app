import 'package:flutter_test/flutter_test.dart';
import 'package:feed_me/data/models/object_of_restaurant.dart';

var testSingleRestaurantJsonParsing = {
  "id": "fnfn8mytkpmkfw1e867",
  "name": "Makan mudah",
  "description":
      "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...",
  "pictureId": "22",
  "city": "Medan",
  "rating": 3.7
};

void main() {
  test("Json Parsing Test", () async {
    var expected = "fnfn8mytkpmkfw1e867";
    var result =
        ObjectOfRestaurant.fromJson(testSingleRestaurantJsonParsing).id;
    expect(result, expected);
  });
}
