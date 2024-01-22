import 'dart:io';

import 'package:bhedhuk_app/pages/favorites_list_page.dart';
import 'package:bhedhuk_app/pages/feed_list_page.dart';
import 'package:bhedhuk_app/widgets/platform_of_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBarPage extends StatefulWidget {
  static const route = '/navbar_page';

  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  final List<BottomNavigationBarItem> _navBarPageItem = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.feed),
      label: 'Feeds',
    ),
    BottomNavigationBarItem(
      icon: Icon(
          Platform.isIOS ? CupertinoIcons.square_favorites : Icons.favorite),
      label: 'Favorites',
    ),
  ];

  final List<Widget> _listPage = [
    FeedListPage(),
    FavoritesListPage(),
  ];

  int _navBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PlatformOfWidget(
      androidUserBuilder: _buildAndroidUser,
      iosUserBuilder: _buildIosUser,
    );
  }

  Widget _buildAndroidUser(BuildContext context) {
    return Scaffold(
      body: _listPage[_navBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _navBarPageItem,
        currentIndex: _navBarIndex,
        onTap: (selected) {
          setState(() {
            _navBarIndex = selected;
          });
        },
      ),
    );
  }

  Widget _buildIosUser(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Colors.yellow,
        items: _navBarPageItem,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 1:
            return const FavoritesListPage();
          default:
            return const FeedListPage();
        }
      },
    );
  }
}
