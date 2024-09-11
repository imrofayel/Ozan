import 'package:flutter/material.dart';
import 'package:ozan/providers/preferences.dart';
import 'package:ozan/theme/colored/blue.dart';
import 'package:ozan/theme/colored/brown.dart';
import 'package:ozan/theme/colored/green.dart';
import 'package:provider/provider.dart';

class ThemeAndFontProvider with ChangeNotifier {
  ThemeData _themeData;
  String _fontFamily;

  ThemeAndFontProvider(this._themeData, this._fontFamily);

  ThemeData get themeData => _themeData;

  String get fontFamily => _fontFamily;

  set themeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  set fontFamily(String font) {
    _fontFamily = font;
    notifyListeners();
  }

  void setFontFamily(String font, BuildContext context) {
    fontFamily = font;
    Provider.of<AppState>(context, listen: false).setFontFamily(font);
    updateTheme(context);
  }

  void toggleBrown(context) {
    themeData = Brown.lightTheme(fontFamily);
    _saveTheme('brown', context);
  }

  void toggleBlue(context) {
    themeData = Blue.lightTheme(fontFamily);
    _saveTheme('blue', context);
  }

  void toggleGreen(context) {
    themeData = Green.lightTheme(fontFamily);
    _saveTheme('green', context);
  }

  void updateTheme(context) {
    if (_themeData == Brown.lightTheme(_fontFamily)) {
      toggleBrown(context);
    } else if (_themeData == Blue.lightTheme(_fontFamily)) {
      toggleBlue(context);
    } else {
      toggleGreen(context);
    }
  }

  void _saveTheme(String themeName, BuildContext context) {
    Provider.of<AppState>(context, listen: false).setTheme(themeName);
  }
}
