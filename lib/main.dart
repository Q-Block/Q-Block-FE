import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/home/presentation/home_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // String clientId = const String.fromEnvironment('NAVER_MAP_CLIENT_ID');
  String clientId = 'ub6c5z1yy9';
  await NaverMapSdk.instance.initialize(clientId: clientId);
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
        primaryColor: const Color(0xFF54715B),
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
    bool isLoggedIn = true;

    // Navigate to the appropriate screen based on the login status
    if (isLoggedIn) {
      return HomeScreen();
    } else {
      return const LogInScreen();
    }
  }
}

