import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ozan/views/notes_view.dart';

class Navigation with ChangeNotifier {

  Widget _current = const NotesView();

  Widget get current => _current;

  void getPage(Widget value) {
    _current = value;
    notifyListeners();
  }

}