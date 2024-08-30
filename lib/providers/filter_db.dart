import 'package:flutter/material.dart';

class FilterState with ChangeNotifier {

  bool _showFavouritesOnly = false;

  bool get showFavouritesOnly => _showFavouritesOnly;

  void setShowFavouritesOnly(bool value) {
    _showFavouritesOnly = value;
    notifyListeners();
  }

  bool isBookmark(){
    return showFavouritesOnly;
  }

  void toggleShowFavouritesOnly() {
    _showFavouritesOnly = !_showFavouritesOnly;
    notifyListeners();
  }
}