import 'package:flutter/material.dart';

class UtilsProvider extends ChangeNotifier {
  int _selectedPage = 1;
  bool _isFavorite = false;

  int get selectedPage => _selectedPage;
  bool get isFavorite => _isFavorite;

  void setSelectedPage(int index) {
    _selectedPage = index;
    notifyListeners();
  }

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}
