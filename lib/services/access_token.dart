import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getSpotifyAccessToken() async {
  final String clientId = '2826200f14b643fda7e90491f024f5bb';
  final String clientSecret = 'dcdc1fb99b07484895024d5eac4f1c66';
  final String credentials = '$clientId:$clientSecret';
  final String encodedCredentials = base64.encode(utf8.encode(credentials));
  final String authUrl = 'https://accounts.spotify.com/api/token';
  final String body = 'grant_type=client_credentials';

  final http.Response response = await http.post(
    Uri.parse(authUrl),
    headers: {
      'Authorization': 'Basic $encodedCredentials',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: body,
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return data['access_token'];
  } else {
    throw Exception('Failed to get access token');
  }
}
