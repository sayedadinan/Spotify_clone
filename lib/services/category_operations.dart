import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryOperations {
  static Future<Map<String, dynamic>?> fetchAlbumData(String albumId) async {
    final String url = 'https://api.spotify.com/v1/albums/$albumId';
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer YOUR_ACCESS_TOKEN_HERE',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String imageUrl = data['images'][0]['url'];
      final String albumName = data['name'];
      final List<String> genres = List<String>.from(data['genres']);
      // You can extract other data as needed
      return {
        'imageUrl': imageUrl,
        'albumName': albumName,
        'genres': genres,
        // Add more fields here as needed
      };
    } else {
      throw Exception('Failed to load album data');
    }
  }
}
