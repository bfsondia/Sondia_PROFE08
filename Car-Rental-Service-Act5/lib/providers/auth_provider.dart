import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isAuthenticated = false;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;

  // Login method
  Future<bool> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Simple validation (in real app, validate against backend)
    if (email.isNotEmpty && password.length >= 6) {
      _currentUser = User(
        id: '1',
        name: email.split('@')[0],
        email: email,
        phone: '+1234567890',
      );
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  // Sign up method
  Future<bool> signUp(String name, String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Simple validation
    if (name.isNotEmpty && email.isNotEmpty && password.length >= 6) {
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        phone: '',
      );
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  // Logout method
  void logout() {
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
