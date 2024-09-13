import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primaryColor: const Color(0xFF364B3B),
      ),
      home: const RootScreen(),
    );
  }
}

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this with your actual login check logic
    bool isLoggedIn = false;

    // Navigate to the appropriate screen based on the login status
    if (isLoggedIn) {
      return const HomeScreen();
    } else {
      return const LogInScreen();
    }
  }
}
