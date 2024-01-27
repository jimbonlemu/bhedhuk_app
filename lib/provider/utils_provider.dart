import 'package:flutter/material.dart';

class UtilsProvider extends ChangeNotifier {
  int _selectedPage = 1;
  bool _isFavorite = false;
  int _navBarIndex = 0;

  int get selectedPage => _selectedPage;
  bool get isFavorite => _isFavorite;
  int get navBarIndex => _navBarIndex;

  void setSelectedPage(int index) {
    _selectedPage = index;
    notifyListeners();
  }

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  void toggleNavbar(int selected) {
    _navBarIndex = selected;
    notifyListeners();
  }
}
