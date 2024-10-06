/*
class AuthService {
  Future<bool> login(String email, String password) async {
    // Replace with actual API request
    const hardcodedEmail = '123@test.com';
    const hardcodedPassword = 'test';

    if (email == hardcodedEmail && password == hardcodedPassword) {
      return true; // Simulate successful login
    } else {
      return false; // Simulate login failure
    }
  }
}
*/
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String? baseUrl = dotenv.env['baseURL'];
  static const String defaultEmail = '123';
  static const String defaultPassword = 'test';

  Future<bool> login(String email, String password) async {
    if (email == defaultEmail && password == defaultPassword) {
      print('Logged in with default credentials.');
      // Simulate successful login without a network call
      final accessToken =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo1LCJlbWFpbCI6IkFXUyIsImlhdCI6MTcyODA2NjU3OCwiZXhwIjoxNzI4NjcxMzc4fQ.oG8C9Un6ZAUNjOd8p22jrsiOoABGLCShJu-28DXoQzY'; // dummy token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', accessToken);
      return true; // Login was successful
    }

    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData['isSuccess']) {
        final accessToken = responseData['result']['refreshToken'];
        print('Login successful, token: $accessToken');

        // Save the token to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);

        print('Token saved to client.');
        return true; // Login was successful
      } else {
        print('Login failed: ${responseData['message']}');
        return false; // Login failed
      }
    } else {
      print('Error during login: ${response.statusCode} ${response.body}');
      return false; // Error occurred
    }
  }

// To retrieve the saved token later
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<void> signUp(String email, String password, String nickname) async {
    final url = Uri.parse('$baseUrl/auth/signup');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'nickname': nickname,
      }),
    );

    if (response.statusCode == 201) {
      // Handle successful signup
      print('Signup successful: ${response.body}');
    } else {
      // Handle error
      print('Signup failed: ${response.statusCode} ${response.body}');
    }
  }
}
