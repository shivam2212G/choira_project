import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/track.dart';

class ApiService {
  static const String baseUrl = 'https://api.jamendo.com/v3.0';
  static final String clientId = dotenv.env['JAMENDO_CLIENT_ID'] ?? '';

  Future<List<Track>> fetchTracks({int limit = 20, int offset = 0, String? query}) async {
    final String url = query != null && query.isNotEmpty
        ? '$baseUrl/tracks/?client_id=$clientId&format=json&namesearch=$query&limit=$limit&offset=$offset'
        : '$baseUrl/tracks/?client_id=$clientId&format=json&limit=$limit&offset=$offset';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => Track.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load tracks');
      }
    } catch (e) {
      throw Exception('Error fetching tracks: $e');
    }
  }
}
