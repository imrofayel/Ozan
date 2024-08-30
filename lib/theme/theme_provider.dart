// import 'package:flutter/material.dart';
// import 'package:ozan/providers/preferences.dart';
// import 'package:ozan/theme/theme.dart';
// import 'package:provider/provider.dart';
// class ThemeSwitcher with ChangeNotifier {
//   late ThemeData _themeData;

//   ThemeSwitcher(BuildContext context) {
//     _themeData = Provider.of<AppState>(context, listen: false).isDarkMode
//         ? Themes.darkTheme
//         : Themes.lightTheme;
//   }

//   ThemeData get themeData => _themeData;

//   set themeData(ThemeData theme) {
//     _themeData = theme;
//     notifyListeners();
//   }

//   void toggleTheme(BuildContext context) {
//     final appState = Provider.of<AppState>(context, listen: false);
//     if (_themeData == Themes.lightTheme) {
//       _themeData = Themes.darkTheme;
//       appState.setDarkMode(true);
//     } else {
//       _themeData = Themes.lightTheme;
//       appState.setDarkMode(false);
//     }
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:ozan/theme/theme.dart';
class ThemeSwitcher with ChangeNotifier{

  ThemeData _themeData = Themes.lightTheme;

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
