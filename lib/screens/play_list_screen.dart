import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicplayerapp/widgets/playlist_icon.dart';

import 'category_song_screen.dart';

class PlayListScreen extends StatefulWidget {
  @override
  _PlayListScreenState createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  FlutterAudioQuery flutterAudioQuery = FlutterAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FutureBuilder(
            future: flutterAudioQuery.getPlaylists(
                sortType: PlaylistSortType.NEWEST_FIRST),
            builder: (context, snapshot) {
              List<PlaylistInfo> playListArray = snapshot.data;
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.only(top: 10.0),
                      onTap: () {},
                      leading: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "New Playlist",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        //padding: EdgeInsets.all(0.0),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: playListArray.length ?? 0,
                        itemBuilder: (context, index) {
                          PlaylistInfo playList = playListArray[index];
                          return ListTile(
                            contentPadding: EdgeInsets.all(0.0),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CategorySongScreen(
                                  dataModel: flutterAudioQuery
                                      .getSongsFromPlaylist(playlist: playList),
                                );
                              }));
                            },
                            leading: PlayListIcon(),
                            title: Text(
                              playList.name,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14.0),
                            ),
                            subtitle: Text(
                              playList.creationDate,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              }
              return Container();
            },
          ),
        )
      ],
    );
  }
}
