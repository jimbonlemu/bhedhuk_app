import 'package:flutter/material.dart';

class FeedListPageProvider extends ChangeNotifier {
  int _selectedPage = 1;

  int get selectedPage => _selectedPage;

  void setSelectedPage(int index) {
    _selectedPage = index;
    notifyListeners();
  }
}
