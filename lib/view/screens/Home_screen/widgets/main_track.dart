import 'package:flutter/material.dart';
import 'package:netflix/models/track_model.dart';
import 'package:netflix/services/base_client.dart';

class MainTrackWidget extends StatefulWidget {
  final String title;
  final String url;
  final List<SpotifyTrack>? data;

  MainTrackWidget({required this.title, this.data, required this.url});

  @override
  _MainTrackWidgetState createState() => _MainTrackWidgetState();
}

class _MainTrackWidgetState extends State<MainTrackWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<List<SpotifyTrack>>? _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = widget.data == null ? fetchItemsToScreen() : null;
  }

  Future<List<SpotifyTrack>> fetchItemsToScreen() async {
    try {
      List<SpotifyTrack> fetchedData =
          await SpotifyApiService.fetchTrackItems(widget.url);
      return fetchedData;
    } catch (e) {
      print('Error occurred while fetching item: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build to enable AutomaticKeepAlive

    return Container(
      child: _dataFuture == null
          ? Center(
              child: widget.data != null
                  ? _buildTrackWidget(widget.data!)
                  : Container(),
            )
          : FutureBuilder<List<SpotifyTrack>>(
              future: _dataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Container());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error occurred while fetching item'));
                } else if (snapshot.hasData) {
                  return _buildTrackWidget(snapshot.data!);
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
    );
  }

  Widget _buildTrackWidget(List<SpotifyTrack> trackList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.title,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        SizedBox(height: 25),
        Container(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: trackList.length,
            itemBuilder: (context, index) {
              final track = trackList[index];
              final imageUrl = track.coverImagePath;
              final title = track.title;
              final subtitle = track.subtitle;

              return Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  height: 150,
                  width: 150,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Image.network(
                            imageUrl,
                            filterQuality: FilterQuality.low,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '$title',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '$subtitle',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
