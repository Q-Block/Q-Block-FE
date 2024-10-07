import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RecordsService {
  final String? baseUrl = dotenv.env['AI_URL'];

  // Function to send POST request with token and get records
  Future<List<Map<String, dynamic>>> getRecords() async {
    final url = Uri.parse('$baseUrl/record');

    // Retrieve the Bearer token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    if (token == null) {
      print('No access token found.');
      return []; // Return an empty list if no token is found
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Include token in the header
        },
      );

      // Check for successful response
      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> responseData = json.decode(response.body);

        // Ensure it's a list of maps (JSON objects)
        return responseData
            .map((record) => record as Map<String, dynamic>)
            .toList();
      } else {
        throw Exception('Failed to load records: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error fetching records: $e');
      return []; // Return an empty list on error
    }
  }
}
