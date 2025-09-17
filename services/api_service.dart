import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Example method to fetch data from an API
  Future<Map<String, dynamic>> fetchSomeData(String endpoint) async {
    final Uri url = Uri.parse(endpoint);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}
