import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 1. Create a class to manage your app state
class AppState with ChangeNotifier {
  late SharedPreferences _prefs;
  String _userName = 'User';
  String _apiKey = '';

  String get userName => _userName;
  String get apiKey => _apiKey;

  AppState() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _userName = _prefs.getString('userName') ?? 'User';
    _apiKey = _prefs.getString('apiKey') ?? '';
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