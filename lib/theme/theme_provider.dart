// import 'package:flutter/material.dart';
// import 'package:ozan/theme/colored/blue.dart';
// import 'package:ozan/theme/colored/brown.dart';
// import 'package:ozan/theme/colored/green.dart';
// class ThemeSwitcher with ChangeNotifier{

//   ThemeData _themeData = Brown.lightTheme;

//   ThemeData get themeData => _themeData;

//   set themeData(ThemeData theme){
//     _themeData = theme;
//     notifyListeners();
//   }

//   void toggleBrown(){

//     themeData = Brown.lightTheme;

//   }

//   void toggleBlue(){

//     themeData = Blue.lightTheme;

//   }

//   void toggleGreen(){

//     // themeData = Green.lightTheme;
    
//   }
// }

import 'package:flutter/material.dart';
import 'package:ozan/theme/colored/blue.dart';
import 'package:ozan/theme/colored/brown.dart';
import 'package:ozan/theme/colored/green.dart';

class ThemeAndFontProvider with ChangeNotifier {
  ThemeData _themeData = Brown.lightTheme(_fontFamily);

  static String _fontFamily = 'Lora'; // Default font

  ThemeData get themeData => _themeData;

   String get fontFamily => _fontFamily;

    set themeData(ThemeData theme){
    _themeData = theme;
    notifyListeners();
  }

    set fontFamily(String font){
    _fontFamily = font;
    notifyListeners();
  }

  void setFontFamily(String font){
    fontFamily = font;
    updateTheme();
  }

  void toggleBrown() {
    themeData = Brown.lightTheme(fontFamily);
  }

  void toggleBlue() {
    themeData = Blue.lightTheme(fontFamily);
  }

  void toggleGreen() {
    themeData = Green.lightTheme(fontFamily);
  }

  void updateTheme() {
    toggleGreen();
  }
}
