class SpotifyTrack {
  final String coverImagePath;
  final String title;
  final String subtitle;

  SpotifyTrack(this.coverImagePath, this.title, this.subtitle);

  factory SpotifyTrack.fromJsonForPlaylist(Map<String, dynamic> json) {
    final images = json['images'] as List<dynamic>?;
    final coverImagePath = images != null && images.isNotEmpty
        ? images[0]['url'] as String
        : 'default_cover_image_url';

    return SpotifyTrack(
      coverImagePath,
      json['name'] as String,
      json['description'] as String,
    );
  }

  factory SpotifyTrack.fromJsonForTrack(Map<String, dynamic> json) {
    final album = json['album'];
    final artists = json['artists'] as List<dynamic>;
    final artistName = artists.isNotEmpty ? artists[0]['name'] as String : '';

    final images = album['images'] as List<dynamic>?;
    final coverImagePath = images != null && images.isNotEmpty
        ? images[0]['url'] as String
        : 'default_cover_image_url';

    return SpotifyTrack(
      coverImagePath,
      json['name'] as String,
      artistName,
    );
  }
}
