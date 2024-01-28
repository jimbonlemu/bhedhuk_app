import 'package:bhedhuk_app/data/api/api_service.dart';
import 'package:bhedhuk_app/utils/styles.dart';
import 'package:bhedhuk_app/widgets/custom_appbar_widget.dart';
import 'package:bhedhuk_app/widgets/feed_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/feed_search_provider.dart';

class FeedSearchPage extends StatefulWidget {
  static const route = '/feed_search_page';
  FeedSearchPage({super.key});

  @override
  State<FeedSearchPage> createState() => _FeedSearchPageState();
}

class _FeedSearchPageState extends State<FeedSearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: "Search Your Feeds",
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceMaterialTransparency: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            floating: true,
            snap: true,
            bottom: const PreferredSize(
                preferredSize: const Size.fromHeight(45.0), child: SizedBox()),
            flexibleSpace: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                margin: EdgeInsets.zero,
                child: Container(
                  margin: EdgeInsets.zero,
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20) / 2,
                    color: whiteColor,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: searchController,
                      style: const TextStyle(fontSize: 20),
                      onSubmitted: (value) async {
                        Provider.of<FeedSearchProvider>(context, listen: false).search(value);
                      },
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 12.0),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          suffixIcon: Material(
                            child: InkWell(
                              onTap: () {

                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                  width: 30,
                                  height: 30,
                                  padding: EdgeInsets.only(top: 12.0),
                                  child: Icon(CupertinoIcons.search)),
                            ),
                          ),
                          hintText: 'Type your feed for today ..',
                          hintStyle: bhedhukTextTheme.bodyLarge),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Consumer<FeedSearchProvider>(
            builder: (context, feedSearchProvider, child) {
              if (feedSearchProvider.isLoading) {
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (feedSearchProvider.listOfRestaurantObjectResponse !=
                  null) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      var restaurant = feedSearchProvider
                          .listOfRestaurantObjectResponse!
                          .listobjectOfRestaurant[index];
                      return FeedItemWidget(restaurant: restaurant);
                    },
                    childCount: feedSearchProvider
                        .listOfRestaurantObjectResponse!
                        .listobjectOfRestaurant
                        .length,
                  ),
                );
              } else {
                return SliverFillRemaining(
                  child: Center(child: Text('No results')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
