import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NicknameChangeService {
  // Function to change the user's nickname
  Future<Map<String, dynamic>> changeNickname(String newNickname) async {
    final url = Uri.parse('http://52.79.170.78:3000/users/info/nickname');

    // Retrieve the token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    if (token == null) {
      throw Exception('No access token found. Please log in again.');
    }
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // 토큰을 Authorization 헤더에 추가
      },
      body: jsonEncode({
        'nickname': newNickname, // 요청 바디에 새 닉네임 추가
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to change nickname: ${response.body}');
    }
  }
}
