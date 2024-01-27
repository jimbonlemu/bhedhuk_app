import 'package:bhedhuk_app/data/api/api_service.dart';
import 'package:bhedhuk_app/provider/detail_feed_item_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/response_result.dart';

class DumpFeed extends StatelessWidget {
  final String restaurantId;

 const DumpFeed({required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailFeedProvider(
        apiService: ApiService(),
        id: restaurantId,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Restaurant Details'),
        ),
        body: Consumer<DetailFeedProvider>(
          builder: (context, detailFeedProvider, child) {
            if (detailFeedProvider.responseResult == ResponseResult.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (detailFeedProvider.responseResult ==
                ResponseResult.noData) {
              return Center(child: Text('No data'));
            } else if (detailFeedProvider.responseResult ==
                ResponseResult.error) {

              return Center(child: Text('An error occurred'));
            } else {
              final restaurantDetails =
                  detailFeedProvider.objectOfRestaurantDetailObjectResponse;
              return ListView(
                children: <Widget>[
                  Text(
                      'Name: ${restaurantDetails.objectOfRestaurantDetail.name}'),
                  // Add more fields here
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
