import 'package:flutter/material.dart';
import 'package:netflix/models/podcast.dart';
import 'package:netflix/services/api_endpoints.dart';
import 'package:netflix/services/base_client.dart';
import 'package:palette_generator/palette_generator.dart';

class MainPodcastWidget extends StatefulWidget {
  final List<SpotifyPodcast>? data;

  MainPodcastWidget({this.data});

  @override
  State<MainPodcastWidget> createState() => _MainPodcastWidgetState();
}

class _MainPodcastWidgetState extends State<MainPodcastWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<List<SpotifyPodcast>>? _dataFuture;
  List<PaletteGenerator?> _paletteGenerators = [];

  @override
  void initState() {
    super.initState();
    _dataFuture = widget.data == null ? fetchItemsToScreen() : null;
  }

  Future<List<SpotifyPodcast>> fetchItemsToScreen() async {
    try {
      List<SpotifyPodcast> fetchedData =
          await SpotifyApiService.fetchPodcastItems(ApiEndPoints.podcasts);

      for (var podcast in fetchedData) {
        final albumCoverImage = podcast.podCastcoverImagePath;
        await _generatePalette(albumCoverImage);
      }
      return fetchedData;
    } catch (e) {
      print('Error occurred while fetching items: $e');
      throw e;
    }
  }

  Future<void> _generatePalette(String albumCoverImage) async {
    final imageProvider = NetworkImage(albumCoverImage);
    final paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    setState(() {
      _paletteGenerators.add(paletteGenerator);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: _dataFuture == null
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<List<SpotifyPodcast>>(
              future: _dataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error occurred while fetching items'));
                } else if (snapshot.hasData) {
                  return _buildPodcastWidget(snapshot.data!,
                      paletteGenerators: _paletteGenerators);
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
    );
  }
}

class _buildPodcastWidget extends StatelessWidget {
  final List<SpotifyPodcast> podcastList;
  final List<PaletteGenerator?> paletteGenerators;

  _buildPodcastWidget(this.podcastList, {required this.paletteGenerators});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: podcastList.length,
      itemBuilder: (context, index) {
        final podcast = podcastList[index];
        final title = podcast.podCasttitle;
        final subtitle = podcast.podCastsubtitle;
        final description = podcast.podCastdescription;
        final date = podcast.podCastDate;
        final coverImage = podcast.podCastcoverImagePath;
        final dominantColor = paletteGenerators.length > index
            ? paletteGenerators[index]?.dominantColor?.color
            : Colors.grey;
        return Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: Container(
                      height: 470,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            dominantColor?.withOpacity(.7) ?? Colors.black54,
                            Colors.grey.shade900,
                          ],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(coverImage),
                              filterQuality: FilterQuality.low,
                              fit: BoxFit.cover,
                            ),
                            color: Colors.black,
                          ),
                          height: 200,
                          width: 200,
                        ),
                        SizedBox(height: 20),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade300,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.add_circle_outline_outlined),
                                SizedBox(width: 20),
                                Icon(Icons.more_vert_outlined),
                              ],
                            ),
                            Row(
                              children: [
                                Text(date),
                                SizedBox(width: 20),
                                Icon(
                                  Icons.play_circle,
                                  size: 32,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
