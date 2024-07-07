import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix/models/podcast.dart';
import 'package:netflix/models/track_model.dart';
import 'package:netflix/services/access_token.dart';

class SpotifyApiService {
  //Podcasts Fetching
  static Future<List<SpotifyPodcast>> fetchPodcastItems(String apiUrl) async {
    final String accessToken = await getSpotifyAccessToken();

    final String randomSeed = DateTime.now().millisecondsSinceEpoch.toString();

    final response = await http.get(
      Uri.parse('$apiUrl$randomSeed'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('albums')) {
        final List<dynamic> albums = jsonResponse['albums']['items'];
        // Shuffle the albums to get random albums
        albums.shuffle();
        return albums
            .map((json) => SpotifyPodcast.fromJsonForPodcast(json))
            .toList();
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  //Track Fetching
  static Future<List<SpotifyTrack>> fetchTrackItems(String apiUrl) async {
    final String accessToken = await getSpotifyAccessToken();

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse.containsKey('playlists')) {
        final List<dynamic> playlists = jsonResponse['playlists']['items'];
        return playlists
            .map((json) => SpotifyTrack.fromJsonForPlaylist(json))
            .toList();
      } else if (jsonResponse.containsKey('tracks')) {
        final List<dynamic> tracks = jsonResponse['tracks'];
        return tracks
            .map((json) => SpotifyTrack.fromJsonForTrack(json))
            .toList();
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  //Searching
  static Future<List<SpotifySearchTrack>> searchItems(String apiUrl) async {
    final String accessToken = await getSpotifyAccessToken();

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse.containsKey('tracks')) {
        final List<dynamic> tracks = jsonResponse['tracks']['items'];
        return tracks.map((json) => SpotifySearchTrack.fromJson(json)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }
}

class SpotifySearchTrack {
  String name;
  String artist;
  String coverImageUrl;

  SpotifySearchTrack({
    required this.name,
    required this.artist,
    required this.coverImageUrl,
  });

  factory SpotifySearchTrack.fromJson(Map<String, dynamic> json) {
    return SpotifySearchTrack(
      name: json['name'] as String,
      artist: json['artists'][0]['name'] as String,
      coverImageUrl: json['album']['images'][0]['url'] as String,
    );
  }
}
