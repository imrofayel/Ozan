import 'package:flutter/material.dart';
import 'package:ozan/theme/colored/blue.dart';
import 'package:ozan/theme/colored/brown.dart';
import 'package:ozan/theme/colored/green.dart';
class ThemeSwitcher with ChangeNotifier{

  ThemeData _themeData = Green.lightTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData theme){
    _themeData = theme;
    notifyListeners();
  }

  void toggleBrown(){

    themeData = Brown.lightTheme;

  }

  void toggleBlue(){

    themeData = Blue.lightTheme;

  }

  void toggleGreen(){

    themeData = Green.lightTheme;
    
  }
}
