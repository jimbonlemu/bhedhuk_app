import 'dart:math';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import '../../data/models/list_of_restaurant_object_api_response.dart';
import '../../provider/utils_provider.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../../widgets/pagination_widget.dart';
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

  void handleOnSubmitted(String value) {
    String trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      AnimatedSnackBar.material('Are you trying to search with blank space ?',
              type: AnimatedSnackBarType.warning,
              duration: const Duration(seconds: 5))
          .show(context);
    } else {
      if (value.length >= 3) {
        Provider.of<FeedSearchProvider>(context, listen: false).search(value);
      } else if (value.length < 3) {
        AnimatedSnackBar.material(
          'Fill search with minimum 3 characters ...',
          type: AnimatedSnackBarType.info,
          duration: const Duration(seconds: 5),
        ).show(context);
      } else {
        Provider.of<UtilsProvider>(context, listen: false).resetSelectedPages();
        Provider.of<FeedSearchProvider>(context, listen: false).clearSearch();
      }
    }
  }

  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController localAnimationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: "Search Your Feeds",
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            forceMaterialTransparency: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            floating: true,
            snap: true,
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(45.0), child: SizedBox()),
            flexibleSpace: _buildSearchBar(),
          ),
          _buildSearchResponse()
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
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
                handleOnSubmitted(value);
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
    );
  }

  Widget _buildSearchResponse() {
    return Consumer2<FeedSearchProvider, UtilsProvider>(
      builder: (context, feedSearchProvider, utilsProvider, child) {
        var searchResult = feedSearchProvider.listOfRestaurantObjectApiResponse;
        int itemsPerPage = 3;
        int selectedPage = utilsProvider.selectedPageListOfSearch;
        if (feedSearchProvider.isTriggeredToLoading) {
          return const SliverFillRemaining(
            child: Center(child: GeneralShimmerWidget()),
          );
        } else if (searchResult != null && searchResult.founded != 0) {
          return _buildListSearchItem(
              feedSearchProvider: feedSearchProvider,
              selectedPage: selectedPage,
              itemsPerPage: itemsPerPage,
              searchResult: searchResult,
              utilsProvider: utilsProvider);
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
    );
  }

  Widget _buildListSearchItem({
    required FeedSearchProvider feedSearchProvider,
    required int selectedPage,
    required int itemsPerPage,
    required ListOfRestaurantObjectApiResponse searchResult,
    required UtilsProvider utilsProvider,
  }) {
    int startIndex = (selectedPage - 1) * itemsPerPage;
    int endIndex = min(startIndex + itemsPerPage, searchResult.founded);
    var pageItems =
        searchResult.listobjectOfRestaurant.sublist(startIndex, endIndex);

    return SliverList.builder(
      itemCount: pageItems.length + 1,
      itemBuilder: (context, index) {
        if (index < pageItems.length) {
          var result = pageItems[index];
          return FeedItemWidget(restaurant: result);
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: PaginationWidget(
                pageCount:
                    (searchResult.listobjectOfRestaurant.length / itemsPerPage)
                        .ceil(),
                selectedPage: selectedPage,
                itemToDisplay: 3,
                onChanged: (page) {
                  if (page != selectedPage) {
                    utilsProvider.setSelectedPageListOfSearch(page);
                    _scrollController.animateTo(
                      0.0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                  }
                }),
          );
        }
      },
    );
  }
}
