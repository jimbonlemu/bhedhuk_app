import 'package:flutter/material.dart';

class UtilsProvider extends ChangeNotifier {
  int _selectedPageListOfRestaurant = 1;
  int _selectedPageListOfSearch = 1;
  int _selectedPageListComment = 1;
  int _selectedPageListFavorited = 1;
  bool _isFavorite = false;
  int _navBarIndex = 0;

  int get selectedPageListOfRestaurant => _selectedPageListOfRestaurant;
  int get selectedPageListOfSearch => _selectedPageListOfSearch;
  int get selectedPageListOfComment => _selectedPageListComment;
  int get selectedPageListFavorited => _selectedPageListFavorited;
  bool get isFavorite => _isFavorite;
  int get navBarIndex => _navBarIndex;

  void listenPageChange(void Function() updateChange) {
    updateChange();
    notifyListeners();
  }

  void resetSelectedPages() {
    _selectedPageListOfSearch = 1;
    _selectedPageListComment = 1;
    _selectedPageListOfSearch = 1;
    notifyListeners();
  }

  void setSelectedPageListOfRestaurant(int index) {
    listenPageChange(() => _selectedPageListOfRestaurant = index);
  }

  void setSelectedPageListOfComment(int index) {
    listenPageChange(() => _selectedPageListComment = index);
  }

  void setSelectedPageListOfSearch(int index) {
    listenPageChange(() => _selectedPageListOfSearch = index);
  }

  void setSelectedPageListOfFavorited(int index) {
    listenPageChange(() => _selectedPageListFavorited = index);
  }

  bool toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
    return _isFavorite;
  }

  void toggleNavbar(int selected) {
    _navBarIndex = selected;
    notifyListeners();
  }
}
