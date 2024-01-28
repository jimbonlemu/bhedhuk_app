import 'package:bhedhuk_app/pages/feed_page/favorites_feed_list_page.dart';
import 'package:bhedhuk_app/pages/feed_page/feed_list_page.dart';
import 'package:bhedhuk_app/pages/feed_page/feed_search_page.dart';
import 'package:bhedhuk_app/provider/utils_provider.dart';
import 'package:bhedhuk_app/widgets/custom_alert_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavBarPage extends StatelessWidget {
  static const route = '/navbar_page';

  NavBarPage({super.key});

  final List<BottomNavigationBarItem> _navBarPageItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.feed),
      label: 'Feeds',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
  ];

  final List<Widget> _listPage = [
    FeedListPage(),
    const FeedSearchPage(),
    const FavoritesListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => showDialog(
        context: context,
        builder: (context) => const CustomAlertDialog(),
      ),
      child: Consumer<UtilsProvider>(
        builder: (context, utilsProvider, child) {
          return Scaffold(
            body: _listPage[utilsProvider.navBarIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: _navBarPageItem,
              currentIndex: utilsProvider.navBarIndex,
              onTap: (selected) {
                utilsProvider.toggleNavbar(selected);
              },
            ),
          );
        },
      ),
    );
  }
}
