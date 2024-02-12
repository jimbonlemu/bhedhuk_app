import 'package:bhedhuk_app/pages/feed_page/favorites_feed_list_page.dart';
import 'package:bhedhuk_app/pages/feed_page/feed_list_page.dart';
import 'package:bhedhuk_app/pages/feed_page/feed_search_page.dart';
import 'package:bhedhuk_app/provider/connecivity_provider.dart';
import 'package:bhedhuk_app/provider/utils_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_alert_dialog_widget.dart';

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
    const FeedListPage(),
    const FeedSearchPage(),
    const FavoritesListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
        builder: (context, connectionStatus, child) {
      if (!connectionStatus.isConnected) {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => showNoInternetDialog(context));
      }
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) => showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            purpose: 'exitAlert',
          ),
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
                  utilsProvider.resetSelectedPages();
                },
              ),
            );
          },
        ),
      );
    });
  }
}
