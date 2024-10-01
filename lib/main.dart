import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/home/presentation/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './features/home/map/map_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // String clientId = const String.fromEnvironment('NAVER_MAP_CLIENT_ID');
  await dotenv.load(fileName: ".env");
  String? clientId = dotenv.env['MAP_clientId'];
  await NaverMapSdk.instance.initialize(clientId: clientId);
  await requestLocationPermission();
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
      //home: HomeScreen(),
      home: LogInScreen(),
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
    /*
    if (isLoggedIn) {
      return HomeScreen();
    } else {
      return const LogInScreen();
    }*/
    return const LogInScreen();
  }
}

// Location service permission request function
Future<void> requestLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle the case when the user denies the location permission
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Handle the case when the user permanently denies the location permission
    return;
  }

  // Permission is granted, you can proceed
}
