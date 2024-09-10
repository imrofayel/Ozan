import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FontChanger with ChangeNotifier {

  String _current = 'Gulzar';

  String get current => _current;

  void changeFont(String font) {
    _current = font;
    notifyListeners();
  }

}