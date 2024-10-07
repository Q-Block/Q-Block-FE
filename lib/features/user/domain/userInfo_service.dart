import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoService {
  // 하드코딩된 토큰을 이곳에 추가
  //final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo1LCJlbWFpbCI6IkFXUyIsImlhdCI6MTcyODA2NjU3OCwiZXhwIjoxNzI4NjcxMzc4fQ.oG8C9Un6ZAUNjOd8p22jrsiOoABGLCShJu-28DXoQzY"; // 실제 액세스 토큰으로 교체

  Future<Map<String, dynamic>?> fetchUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    if (token == null) {
      print('No access token found.');
      return null; // Handle the case where the token is not available
    }

    final response = await http.post(
      Uri.parse('http://52.79.170.78:3000/users/info'),
      headers: {
        'Authorization': 'Bearer $token', // 하드코딩된 토큰 사용
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['isSuccess']) {
        return responseData['result']; // 결과 반환
      } else {
        print('Error: ${responseData['message']}');
      }
    } else {
      print('Error: ${response.statusCode}');
    }
    return null; // 실패 시 null 반환
  }
}
