import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _user;
  UserModel? get user => _user;

  bool get isAuthenticated => _user != null;

  Future<bool> login(String email, String password) async {
    final userData = await _authService.login(email, password);
    if (userData != null) {
      _user = userData;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }

  Future<bool> signup(String email, String password, String displayName) async {
    final userData = await _authService.signup(email, password, displayName);
    if (userData != null) {
      _user = userData;
      notifyListeners();
      return true;
    }
    return false;
  }
}
