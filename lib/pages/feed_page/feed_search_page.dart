import 'dart:math';

import 'package:bhedhuk_app/provider/utils_provider.dart';
import 'package:bhedhuk_app/utils/images.dart';
import 'package:bhedhuk_app/utils/styles.dart';
import 'package:bhedhuk_app/widgets/pagination_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../provider/feed_search_provider.dart';
import '../../widgets/custom_appbar_widget.dart';
import '../../widgets/feed_item_widget.dart';
import '../../widgets/general_shimmer_widget.dart';

class FeedSearchPage extends StatefulWidget {
  static const route = '/feed_search_page';
  const FeedSearchPage({super.key});

  @override
  State<FeedSearchPage> createState() => _FeedSearchPageState();
}

class _FeedSearchPageState extends State<FeedSearchPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<FeedSearchProvider>(context, listen: false).clearSearch();
    });
  }

  TextEditingController searchController = TextEditingController();
  // String _errorValidation = "";
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
                preferredSize: Size.fromHeight(45.0), child: SizedBox()),
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
                      onSubmitted: (value) {
                        if (value.length >= 3) {
                          Provider.of<FeedSearchProvider>(context,
                                  listen: false)
                              .search(value);
                        } else {
                          Provider.of<FeedSearchProvider>(context,
                                  listen: false)
                              .clearSearch();
                        }
                      },
                      // onChanged: (value) {
                      //   if (value.length < 3) {
                      //     _errorValidation =
                      //         "Please fill in at least 3 character";
                      //   } else {
                      //     _errorValidation = "";
                      //   }
                      // },
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          // errorText: _errorValidation,
                          contentPadding: const EdgeInsets.only(top: 12.0),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          suffixIcon: Material(
                            child: Container(
                                width: 30,
                                height: 30,
                                padding: const EdgeInsets.only(top: 12.0),
                                child: const Icon(CupertinoIcons.search)),
                          ),
                          hintText: 'Type your feed for today ..',
                          hintStyle: bhedhukTextTheme.bodyLarge),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Consumer2<FeedSearchProvider, UtilsProvider>(
            builder: (context, feedSearchProvider, utilsProvider, child) {
              var searchResult =
                  feedSearchProvider.listOfRestaurantObjectApiResponse;
              int itemsPerPage = 3;
              int selectedPage = utilsProvider.selectedPage;
              if (feedSearchProvider.isTriggeredToLoading) {
                return const SliverFillRemaining(
                  child: Center(child: GeneralShimmerWidget()),
                );
              } else if (searchResult != null && searchResult.founded != 0) {
                int startIndex = (selectedPage - 1) * itemsPerPage;
                int endIndex = min(
                    startIndex + itemsPerPage,
                    feedSearchProvider
                        .listOfRestaurantObjectApiResponse!.founded);

                var pageItems = feedSearchProvider
                    .listOfRestaurantObjectApiResponse!.listobjectOfRestaurant
                    .sublist(startIndex, endIndex);

                return SliverList.builder(
                  itemCount: pageItems.length + 1,
                  itemBuilder: (context, index) {
                    if (index < pageItems.length) {
                      var result = pageItems[index];
                      return FeedItemWidget(restaurant: result);
                    } else {
                      return PaginationWidget(
                          pageCount: (feedSearchProvider
                                      .listOfRestaurantObjectApiResponse!
                                      .listobjectOfRestaurant
                                      .length /
                                  itemsPerPage)
                              .ceil(),
                          selectedPage: selectedPage,
                          itemToDisplay: 3,
                          onChanged: (page) {
                            if (page != selectedPage) {
                              utilsProvider.setSelectedPage(page);
                            }
                          });
                    }
                  },
                );
                // SliverList(
                //   delegate: SliverChildBuilderDelegate(
                //     (context, index) {
                //       return Text('data');
                //     },
                //     childCount: 4,
                //   ),
                // ),
                // SliverList(
                //   delegate: SliverChildBuilderDelegate(
                //     (BuildContext context, int index) {
                //       return FeedItemWidget(
                //           restaurant:
                //               searchResult.listobjectOfRestaurant[index]);
                //     },
                //     childCount: searchResult.listobjectOfRestaurant.length,
                //   ),
                // ),
                // SliverToBoxAdapter(
                //     child: Text(searchResult.founded.toString())),
              } else if (searchResult != null && searchResult.founded == 0) {
                return SliverFillRemaining(
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      LottieBuilder.asset(Images.lottieNoResult),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 10 * 4 + 15,
                        child: Text(
                          'Looking for something?',
                          style: bhedhukTextTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Get a Good and Best Feed For You!',
                      style: bhedhukTextTheme.headlineSmall,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
