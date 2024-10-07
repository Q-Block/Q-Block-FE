import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogoutService {
  // 하드코딩된 토큰을 이곳에 추가
  //final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo1LCJlbWFpbCI6IkFXUyIsImlhdCI6MTcyODA2NjU3OCwiZXhwIjoxNzI4NjcxMzc4fQ.oG8C9Un6ZAUNjOd8p22jrsiOoABGLCShJu-28DXoQzY"; // 실제 액세스 토큰으로 교체

  Future<Map<String, dynamic>> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token =
        prefs.getString('accessToken'); // Retrieve token from SharedPreferences

    if (token == null) {
      print('No access token found for logout.');
      throw Exception(
          'No access token found'); // Handle the case where the token is not available
    }

    final url = Uri.parse('http://52.79.170.78:3000/users/logout');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // 토큰을 Authorization 헤더에 추가
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to logout: ${response.body}');
    }
  }
}
