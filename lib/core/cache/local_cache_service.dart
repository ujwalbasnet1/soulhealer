import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// This is third party module to cache variables using shared preferences [ LocalCacheService ]
/// PRIMITIVE types [ int, double, String, bool ] can be stored and retrieved through shared preferences directly.
/// For other than that types, function must be passed
/// To store, it must be encoded into json and saved as string
/// To retrieve, it must be decoded from json
///
class LocalCacheService {
  static SharedPreferences preferences;

  /// saves primitive object directly, need to pass toJson for storing other objects
  static void store<T>(String key, T value, {Function toJson}) {
    if (T == int || value is int) {
      preferences.setInt(key, (value as int));
    } else if (T == double || value is double) {
      preferences.setDouble(key, (value as double));
    } else if (T == String || value is String) {
      preferences.setString(key, (value as String));
    } else if (T == bool || value is bool) {
      preferences.setBool(key, (value as bool));
    } else {
      if (toJson != null)
        preferences.setString(key, jsonEncode(toJson(value)));
      else
        throw "LocalCacheObject, Cannot be cached";
    }
  }

  /// retrieves primitive object directly, need to pass fromJson for retrieving other objects
  static retrieve<T>(String key, {Function fromJson}) {
    if (T == int) {
      return preferences.getInt(key);
    } else if (T == double) {
      return preferences.getDouble(key);
    } else if (T == String) {
      return preferences.getString(key);
    } else if (T == bool) {
      return preferences.getBool(key);
    } else {
      if (fromJson != null)
        return fromJson(jsonDecode(preferences.getString(key)));
      else
        throw "LocalCacheObject, Cannot be cached";
    }
  }

  /// clear all the saved caches
  static clear() => preferences.clear();

  /// clear an entry from the cache
  static remove(String key) => preferences.remove(key);
}
