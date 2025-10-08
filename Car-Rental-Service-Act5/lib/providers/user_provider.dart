import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isAuthenticated = false;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = User(
      id: '1',
      name: 'John Doe',
      email: email,
      phone: '+1234567890',
      licenseNumber: 'DL123456',
      licenseExpiry: DateTime.now().add(const Duration(days: 365)),
    );
    _isAuthenticated = true;

    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', _currentUser!.id);
    await prefs.setBool('isAuthenticated', true);

    notifyListeners();
  }

  Future<void> register(User user, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = user;
    _isAuthenticated = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.id);
    await prefs.setBool('isAuthenticated', true);

    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    _isAuthenticated = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    notifyListeners();
  }

  Future<void> updateProfile(User updatedUser) async {
    _currentUser = updatedUser;
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;

    if (_isAuthenticated) {
      final userId = prefs.getString('userId');
      // Load user data from API
      // For now, using dummy data
      _currentUser = User(
        id: userId ?? '1',
        name: 'John Doe',
        email: 'john@example.com',
        phone: '+1234567890',
      );
    }

    notifyListeners();
  }
}
