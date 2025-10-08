import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/cars/car_details_screen.dart';
import 'screens/booking/booking_screen.dart';
import 'screens/booking/booking_confirmation_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/profile/booking_history_screen.dart';

void main() {
  runApp(const CarRentalApp());
}

class CarRentalApp extends StatelessWidget {
  const CarRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DriveNow - Car Rental',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF164e63),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF164e63),
          primary: const Color(0xFF164e63),
          secondary: const Color(0xFF10b981),
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF164e63),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF164e63),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: const Color(0xFFF1F5F9),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/booking-history': (context) => const BookingHistoryScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/car-details') {
          final car = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => CarDetailsScreen(car: car),
          );
        } else if (settings.name == '/booking') {
          final car = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => BookingScreen(car: car),
          );
        } else if (settings.name == '/booking-confirmation') {
          final booking = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => BookingConfirmationScreen(booking: booking),
          );
        }
        return null;
      },
    );
  }
}
