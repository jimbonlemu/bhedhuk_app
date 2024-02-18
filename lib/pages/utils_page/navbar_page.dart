import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../feed_page/favorites_feed_list_page.dart';
import '../feed_page/feed_detail_page.dart';
import '../feed_page/feed_list_page.dart';
import '../feed_page/feed_search_page.dart';
import '../../provider/connecivity_provider.dart';
import '../../provider/utils_provider.dart';
import '../../utils/notification_service.dart';
import '../../widgets/custom_alert_dialog_widget.dart';

class NavBarPage extends StatefulWidget {
  static const route = '/navbar_page';

  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  final FeedNotificationService _feedNotificationService =
      FeedNotificationService();

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
  void initState() {
    super.initState();
    _feedNotificationService
        .configureSelectNotificationSubject(FeedDetailPage.route);
  }

  @override
  void dispose() {
    super.dispose();
    selectedFeedInNotification.close();
  }

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
                  utilsProvider.setSelectedPageListOfFavorited(1);
                },
              ),
            );
          },
        ),
      );
    });
  }
}
