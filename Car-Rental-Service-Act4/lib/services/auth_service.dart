import '../models/user.dart';

class AuthService {
  static User? _currentUser;

  static User? get currentUser => _currentUser;

  static bool get isLoggedIn => _currentUser != null;

  static Future<bool> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Mock authentication - accept any email/password for demo
    if (email.isNotEmpty && password.isNotEmpty) {
      _currentUser = User(
        id: '1',
        name: email.split('@')[0].toUpperCase(),
        email: email,
        phone: '+1 234 567 8900',
      );
      return true;
    }
    return false;
  }

  static Future<bool> register(
      String name, String email, String phone, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      _currentUser = User(
        id: '1',
        name: name,
        email: email,
        phone: phone,
      );
      return true;
    }
    return false;
  }

  static void logout() {
    _currentUser = null;
  }

  static Future<bool> updateProfile(String name, String phone) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (_currentUser != null) {
      _currentUser = User(
        id: _currentUser!.id,
        name: name,
        email: _currentUser!.email,
        phone: phone,
        profileImage: _currentUser!.profileImage,
      );
      return true;
    }
    return false;
  }
}
