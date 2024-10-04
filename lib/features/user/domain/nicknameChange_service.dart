import 'dart:convert';
import 'package:http/http.dart' as http;

class NicknameChangeService {
  // 하드코딩된 토큰을 이곳에 추가
  final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo1LCJlbWFpbCI6IkFXUyIsImlhdCI6MTcyODA2NjU3OCwiZXhwIjoxNzI4NjcxMzc4fQ.oG8C9Un6ZAUNjOd8p22jrsiOoABGLCShJu-28DXoQzY"; // 실제 액세스 토큰으로 교체

  Future<Map<String, dynamic>> changeNickname(String newNickname) async {
    final url = Uri.parse('http://52.79.170.78:3000/users/info/nickname');

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
