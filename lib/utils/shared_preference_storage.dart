import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

import '../data/pojo/user.dart';

class SharedPreferenceStorage {
  static const userKey = "user";

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setLoggedInUser(User? user) async {
    SharedPreferences prefs = await _prefs;
    if (user != null) {
      prefs.setString(userKey, user.toString());
    } else {
      prefs.remove(userKey);
    }
  }

  Future<User?> getLoggedInUser() async {
    SharedPreferences prefs = await _prefs;
    String? userString = prefs.getString(userKey);
    if (userString != null) {
      return User.fromMap(
        convert.jsonDecode(userString) as Map<String, dynamic>,
      );
    } else {
      return null;
    }
  }
}
