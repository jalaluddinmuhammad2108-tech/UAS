import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baca Buku Online',
      theme: ThemeData(
        primaryColor: const Color(0xFF5C4DFF),
        scaffoldBackgroundColor: const Color(0xFFF5F4F9),
      ),
      home: SplashScreen(), // ✅ SPLASH SCREEN
    );
  }
}
