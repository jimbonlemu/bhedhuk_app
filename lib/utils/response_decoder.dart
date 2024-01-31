import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/models/new_data_models/object_of_api_response.dart';

Future<T> responseDecoder<T extends ObjectOfApiResponse>(
    http.Response response, T Function(Map<String, dynamic>) fromJson) async {
  var parsed = jsonDecode(response.body);

  if (parsed == null) {
    throw Exception('The server response was null');
  }
  var apiResponse = fromJson(parsed);

  if (apiResponse.error == true) {
    throw Exception("FROM API SERVICE ---->  ${apiResponse.message}");
  } else {
    return apiResponse;
  }
}
