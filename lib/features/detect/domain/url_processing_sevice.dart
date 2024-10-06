import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UrlProcessingService {
  final String? baseUrl = dotenv.env['AI_URL'];

  Future<Map<String, dynamic>?> processUrl(String url, bool qrStatus) async {
    final endpoint = Uri.parse('$baseUrl/process-url');

    // Retrieve the Bearer token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    if (token == null) {
      print('No access token found.');
      return null;
    }

    try {
      final response = await http.post(
        endpoint,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'url': url,
          'qr_status': qrStatus,
        }),
      );
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Request successful: $responseData');
        return responseData;
      } else {
        print('Error: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }
}
