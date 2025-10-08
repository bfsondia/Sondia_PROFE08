import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/car_provider.dart';
import 'providers/user_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/product_detail.dart';
import 'screens/checkout_screen.dart';
import 'screens/forms/registration_form.dart';
import 'screens/forms/car_form.dart';
import 'screens/navigation/drawer_demo.dart';
import 'screens/navigation/tabs_demo.dart';
import 'screens/media/image_demo.dart';
import 'screens/media/audio_demo.dart';
import 'screens/media/video_demo.dart';
import 'screens/media/qr_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ChangeNotifierProvider<CarProvider>(create: (_) => CarProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Car Rental Services',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF1976D2),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1976D2),
            secondary: const Color(0xFFFF9800),
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/home': (context) => const HomeScreen(),
          '/cart': (context) => const CartScreen(),
          '/checkout': (context) => const CheckoutScreen(),
          '/registration': (context) => const RegistrationForm(),
          '/car-form': (context) => const CarForm(),
          '/drawer-demo': (context) => const DrawerDemo(),
          '/tabs-demo': (context) => const TabsDemo(),
          '/image-demo': (context) => const ImageDemo(),
          '/audio-demo': (context) => const AudioDemo(),
          '/video-demo': (context) => const VideoDemo(),
          '/qr-scanner': (context) => const QRScanner(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/product-detail') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => ProductDetail(carId: args['carId']),
            );
          }
          return null;
        },
      ),
    );
  }
}
