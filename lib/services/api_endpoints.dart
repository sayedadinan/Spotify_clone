const BaseUrl = 'https://api.spotify.com/v1';

class ApiEndPoints {
  //Latest Releases
  static const latestReleases = '$BaseUrl/browse/new-releases?limit=10';

  //Recommendations
  static const recommendations1 =
      '$BaseUrl/recommendations?&seed_genres=indian%2Ccountry&seed_tracks=0c6xIDDpzE81m2q797ordA';

  static const recommendations2 =
      '$BaseUrl/recommendations?&seed_genres=classical%2Ccountry&seed_tracks=0c6xIDDpzE81m2q797ordA';

  static const recommendations3 =
      '$BaseUrl/recommendations?&seed_genres=classical%2Ccountry&seed_tracks=0c6xIDDpzE81m2q797ordA';

  static const recommendations4 =
      '$BaseUrl/recommendations?&seed_genres=hindi%2Ccountry&seed_tracks=0c6xIDDpzE81m2q797ordA';

  static const recommendations5 =
      '$BaseUrl/recommendations?&seed_genres=punjabi%2Ccountry&seed_tracks=0c6xIDDpzE81m2q797ordA';

  //Featured Playlists
  static const featuredPlaylists = '$BaseUrl/browse/featured-playlists';

  //Podcast
  static const podcasts = '$BaseUrl/search?q=album&type=album&limit=10&seed=';
}
