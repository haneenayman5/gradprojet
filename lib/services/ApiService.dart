import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://gradprojapi.somee.com/api"; // Replace with your .NET API URL

  static Future<Map<String, dynamic>?> postRequest(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(data),
      );
      print('Response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return {"success": false, "message": "Error: ${response.statusCode}"};
      }
    } catch (error) {
      return {"success": false, "message": "Exception: $error"};
    }
  }
}
