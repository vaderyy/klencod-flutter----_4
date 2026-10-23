import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const FezzanUniversityApp());
}

class FezzanUniversityApp extends StatelessWidget {
  const FezzanUniversityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'جامعة فزان',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.isDarkMode ? _darkTheme() : _lightTheme(),
            initialRoute: '/splash',
            routes: {
              '/splash': (context) => const SplashScreen(),
              '/login': (context) => const LoginScreen(),
              '/home': (context) => const HomeScreen(),
            },
          );
        },
      ),
    );
  }

  // ثيم نهاري - خط iPhone
  ThemeData _lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF1E3A8A),
      scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      fontFamily: 'SF Pro Display', // خط iPhone
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.bold),
        displayMedium: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.bold),
        displaySmall: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.w600),
        titleSmall: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontFamily: 'SF Pro Display'),
        bodyMedium: TextStyle(fontFamily: 'SF Pro Display'),
        bodySmall: TextStyle(fontFamily: 'SF Pro Display'),
        labelLarge: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.w500),
        labelMedium: TextStyle(fontFamily: 'SF Pro Display'),
        labelSmall: TextStyle(fontFamily: 'SF Pro Display'),
      ),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF1E3A8A),
        secondary: Color(0xFF3B82F6),
        surface: Colors.white,
      ),
    );
  }

  // ثيم ليلي - خط iPhone
  ThemeData _darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF3B82F6),
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      fontFamily: 'SF Pro Display', // خط iPhone
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.bold, color: Colors.white),
        displayMedium: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.bold, color: Colors.white),
        displaySmall: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.bold, color: Colors.white),
        headlineLarge: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.bold, color: Colors.white),
        headlineMedium: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.bold, color: Colors.white),
        headlineSmall: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.bold, color: Colors.white),
        titleLarge: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.w600, color: Colors.white),
        titleMedium: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.w600, color: Colors.white),
        titleSmall: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: TextStyle(fontFamily: 'SF Pro Display', color: Colors.white),
        bodyMedium: TextStyle(fontFamily: 'SF Pro Display', color: Colors.white70),
        bodySmall: TextStyle(fontFamily: 'SF Pro Display', color: Colors.white60),
        labelLarge: TextStyle(fontFamily: 'SF Pro Display', fontWeight: FontWeight.w500, color: Colors.white),
        labelMedium: TextStyle(fontFamily: 'SF Pro Display', color: Colors.white70),
        labelSmall: TextStyle(fontFamily: 'SF Pro Display', color: Colors.white60),
      ),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF3B82F6),
        secondary: Color(0xFF60A5FA),
        surface: Color(0xFF1E293B),
      ),
    );
  }
}