import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _accessToken;
  String? _refreshToken;
  String? _role;
  String? _name;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  String? get role => _role;
  String? get name => _name;

  bool get isLoggedIn => _accessToken != null;

  void setAuthData({
    required String accessToken,
    required String refreshToken,
    required String role,
    required String name,
  }) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _role = role;
    _name = name;

    notifyListeners();
  }

  void updateAccessToken(String newAccessToken) {
    _accessToken = newAccessToken;
    notifyListeners();
  }

  void logout() {
    _accessToken = null;
    _refreshToken = null;
    _role = null;
    _name = null;
    notifyListeners();
  }
}
