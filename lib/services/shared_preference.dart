import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesService {
  static final SharedPreferencesService _instance = SharedPreferencesService._internal();
  factory SharedPreferencesService() => _instance;
  SharedPreferencesService._internal();

  /// Cache user data locally in Shared Preferences
  Future<void> cacheUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonData = json.encode(userData);
    await prefs.setString("userData", jsonData);
  }

  /// Retrieve cached user data from Shared Preferences
  Future<Map<String, dynamic>?> getCachedUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString("userData");
    if (jsonData != null) {
      return json.decode(jsonData) as Map<String, dynamic>;
    }
    return null;
  }

  /// Clear cached user data
  Future<void> clearCachedUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("userData");
  }
}
