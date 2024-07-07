// class SpotifyPodcast {
//   String name;
//   String artist;
//   String coverImageUrl;

//   SpotifyPodcast({
//     required this.name,
//     required this.artist,
//     required this.coverImageUrl,
//   });

//   factory SpotifyPodcast.fromJsonForPodcast(Map<String, dynamic> json) {
//     return SpotifyPodcast(
//       name: json['name'] as String,
//       artist: json['artist'] as String, // Adjust as per your JSON structure
//       coverImageUrl:
//           json['coverImageUrl'] as String, // Adjust as per your JSON structure
//     );
//   }
// }

class SpotifyPodcast {
  final String podCastcoverImagePath;
  final String podCasttitle;
  final String podCastsubtitle;
  final String podCastdescription;
  final String podCastDate;

  SpotifyPodcast(
    this.podCastcoverImagePath,
    this.podCasttitle,
    this.podCastsubtitle,
    this.podCastdescription,
    this.podCastDate,
  );

  factory SpotifyPodcast.fromJsonForPodcast(Map<String, dynamic> json) {
    final artists = json['artists'] as List<dynamic>;
    final artistName = artists.isNotEmpty ? artists[0]['name'] as String : '';
    final images = json['images'] as List<dynamic>?;
    final coverImagePath = images != null && images.isNotEmpty
        ? images[0]['url'] as String
        : 'default_cover_image_url';

    // final genresList = json['genres'] as List<dynamic>?; // Handle the genres list
    // final genres = genresList?.cast<String>().join(', ') ?? 'Unknown'; // Convert list to a string

    return SpotifyPodcast(
      coverImagePath,
      json['name'] as String? ?? 'Unknown',
      json['album_type'] as String? ??
          'Unknown', // Use album_type instead of type
      json['release_date'] as String? ?? 'Test',

      artistName,
    );
  }
}
