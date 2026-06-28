import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';

class AuthProvider extends ChangeNotifier {
  final UserAuthInfo _userAuthInfo = UserAuthInfo(
    id: '',
    role: '',
    accessToken: '',
    refreshToken: '',
  );

  String? get accessToken => _userAuthInfo.accessToken;
  String? get refreshToken => _userAuthInfo.refreshToken;
  String? get role => _userAuthInfo.role;
  String? get id => _userAuthInfo.id;

  // bool get isLoggedIn =>  _userAuthInfo.accessToken ;

  void setAuthData({
    required String accessToken,
    required String refreshToken,
    required String role,
    required String id,
  }) {
    _userAuthInfo.accessToken = accessToken;
    _userAuthInfo.refreshToken = refreshToken;
    _userAuthInfo.role = role;
    _userAuthInfo.id = id;

    notifyListeners();
  }

  // void updateAccessToken(String newAccessToken) {
  //   _accessToken = newAccessToken;
  //   notifyListeners();
  // }

  // void logout() {
  //   _accessToken = null;
  //   _refreshToken = null;
  //   _role = null;
  //   _name = null;
  //   notifyListeners();
  // }
}
