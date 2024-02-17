import 'package:flutter/material.dart';
import 'package:ozan/theme/theme.dart';
class ThemeSwitcher with ChangeNotifier{

  ThemeData _themeData = Themes.darkTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData theme){
    _themeData = theme;
    notifyListeners();
  }

  void toggleTheme(){

    if(themeData == Themes.lightTheme){

      themeData = Themes.darkTheme;
    }
    else{

      themeData = Themes.lightTheme;
    }
  }
}