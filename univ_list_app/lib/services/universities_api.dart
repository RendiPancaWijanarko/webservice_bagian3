import 'dart:convert';
import 'package:http/http.dart' as http;

class UniversitiesApi {
  static const String _baseUrl = 'http://universities.hipolabs.com';
  static const String _searchEndpoint = '/search';
  static const String _countryParam = 'country';

  static Future<List<dynamic>> fetchUniversities(String country) async {
    final response = await http
        .get(Uri.parse('$_baseUrl$_searchEndpoint?$_countryParam=$country'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load universities');
    }
  }
}
