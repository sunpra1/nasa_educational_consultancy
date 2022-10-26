import 'package:flutter/material.dart';

import '../data/pojo/user.dart';
import '../utils/shared_preference_storage.dart';

class UserProvider with ChangeNotifier {
  final SharedPreferenceStorage storage = SharedPreferenceStorage();

  User? _loggedInUser;

  User? get loggedInUser => _loggedInUser;

  UserProvider() {
    _setUserFromStorage();
  }

  Future<void> setLoggedInUser(User? user) async {
    _loggedInUser = user;
    await storage.setLoggedInUser(user);
    notifyListeners();
  }

  Future<void> _setUserFromStorage() async {
    if (_loggedInUser != null) return;
    _loggedInUser = await storage.getLoggedInUser();
    notifyListeners();
  }

  Future<User?> getLoggedInUser() async {
    return _loggedInUser ?? await storage.getLoggedInUser();
  }
}
