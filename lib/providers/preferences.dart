import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState with ChangeNotifier {
  late SharedPreferences _prefs;
  String _userName = 'User';
  String _apiKey = '';
  String _fontFamily = 'Inter';
  String _theme = 'brown';  // Default theme

  String get userName => _userName;
  String get apiKey => _apiKey;
  String get fontFamily => _fontFamily;
  String get theme => _theme;

  AppState() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _userName = _prefs.getString('userName') ?? 'User';
    _apiKey = _prefs.getString('apiKey') ?? '';
    _fontFamily = _prefs.getString('fontFamily') ?? 'Inter';
    _theme = _prefs.getString('theme') ?? 'brown';  // Load theme from prefs
    notifyListeners();
  }

  Future<void> setFontFamily(String value) async {
    _fontFamily = value;
    await _prefs.setString('fontFamily', value);
    notifyListeners();
  }

  Future<void> setTheme(String themeName) async {
    _theme = themeName;
    await _prefs.setString('theme', themeName);
    notifyListeners();
  }

  Future<void> setUserName(String value) async {
    _userName = value;
    await _prefs.setString('userName', value);
    notifyListeners();
  }

  Future<void> setApiKey(String value) async {
    _apiKey = value;
    await _prefs.setString('apiKey', value);
    notifyListeners();
  }
}
