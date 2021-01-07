import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicplayerapp/screens/category_song_screen.dart';
import 'package:musicplayerapp/trest.dart';

class AlbumScreen extends StatefulWidget {
  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  FlutterAudioQuery flutterAudioQuery = FlutterAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FutureBuilder(
            future: flutterAudioQuery.getAlbums(
                sortType: AlbumSortType.ALPHABETIC_ARTIST_NAME),
            // ignore: missing_return
            builder: (context, snapshot) {
              List<AlbumInfo> albumList = snapshot.data;
              if (snapshot.hasData) {
                return ListView.builder(
                  //padding: EdgeInsets.all(0.0),
                  shrinkWrap: true,
                  itemCount: albumList.length,
                  itemBuilder: (context, index) {
                    AlbumInfo albumInfo = albumList[index];
                    return ListTile(
                      contentPadding: EdgeInsets.all(0.0),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CategorySongScreen(
                            dataModel: flutterAudioQuery.getSongsFromAlbum(
                                albumId: albumInfo.id),
                          );
                        }));
                      },
                      leading: SizedBox(
                        width: 40.0,
                        height: 40.0,
                        child: FutureBuilder(
                          future: flutterAudioQuery.getArtwork(
                              type: ResourceType.ALBUM, id: albumInfo.id),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Container();
                            }
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.memory(
                                snapshot.data,
                                fit: BoxFit.cover,
                                height: 50.0,
                                width: 50.0,
                                errorBuilder: (context, o, n) {
                                  return Container(
                                    height: 50.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Image.asset(
                                      "assets/icons/icons8_music_record_64px.png",
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      title: Text(
                        albumInfo.title,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        albumInfo.artist,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: ImageIcon(
                          AssetImage(
                              "assets/icons/icons8_menu_vertical_16px.png"),
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                );
              }
              return Container(
                width: 0.0,
                height: 0.0,
              );
            },
          ),
        ),
      ],
    );
  }
}
