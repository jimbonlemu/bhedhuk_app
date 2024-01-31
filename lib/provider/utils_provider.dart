import 'package:flutter/material.dart';

class UtilsProvider extends ChangeNotifier {
  int _selectedPageListOfRestaurant = 1;
  int _selectedPageListOfSearch = 1;
  int _selectedPageListComment = 1;
  bool _isFavorite = false;
  int _navBarIndex = 0;
  final ScrollController _scrollController = ScrollController();

  int get selectedPageListOfRestaurant => _selectedPageListOfRestaurant;
  int get selectedPageListOfSearch => _selectedPageListOfSearch;
  int get selectedPageListOfComment => _selectedPageListComment;
  bool get isFavorite => _isFavorite;
  int get navBarIndex => _navBarIndex;
  ScrollController get scrollController => _scrollController;

  void listenPageChange(void Function() updateChange) {
    updateChange();
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
