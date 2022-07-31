import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider =
    ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider());

class AuthProvider extends ChangeNotifier {
  bool _authenticated = false;
  bool get isAuthentictated {
    return _authenticated;
  }

  void login() {
    _authenticated = true;
    notifyListeners();
  }

  void logout() {
    _authenticated = false;
    notifyListeners();
  }
}
