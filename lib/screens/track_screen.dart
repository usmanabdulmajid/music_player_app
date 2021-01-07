import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicplayerapp/models/custom_popup_item.dart';
import 'package:musicplayerapp/models/song.dart';
import 'package:musicplayerapp/screens/detail_screen.dart';
import 'package:musicplayerapp/utils/constant_colors.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:musicplayerapp/utils/song_category.dart';
import 'package:musicplayerapp/widgets/play_button.dart';
import 'package:musicplayerapp/widgets/playlist_icon.dart';
import 'package:provider/provider.dart';
import 'package:musicplayerapp/providers/song_controller.dart';

// ignore: must_be_immutable
class TrackScreen extends StatefulWidget {
  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  bool _isPlaying;
  double _slider;
  //var audioManagerInstance = AudioManager.instance;
  //AudioPlayer audioPlayer = AudioPlayer();
  FlutterAudioQuery flutterAudioQuery = FlutterAudioQuery();
  final assetsAudioPlayer = AssetsAudioPlayer();
  SongController controller;

  //List<Song> songs = getSongs();
  int indexSelected;

  Playlist playlist({List<SongInfo> songInfo}) {
    final fetchedAudios = songInfo.map((e) {
      Audio.file(e.filePath,
          metas: Metas(
            artist: e.artist,
            album: e.album,
            title: e.title,
          ));
    }).toList();
    var audios = <Audio>[];
    setState(() {
      audios = fetchedAudios;
    });
    Playlist playlist = Playlist(audios: audios);
    return playlist;
  }

  Playlist newPlaylist;

  void assetAudioPlayerSetUp() async {
    final songs =
        await flutterAudioQuery.getSongs(sortType: SongSortType.DISPLAY_NAME);
    var audios = <Audio>[];
    final fetechedAudios = songs
        .map((s) => Audio.file(s.filePath,
            metas: Metas(
              artist: s.artist,
              album: s.album,
              //image: MetasImage.asset("assets/images/country.jpg"),
              title: s.title,
            )))
        .toList();
    fetechedAudios.forEach((element) {
      print(element.path);
      //print(element.metas.image.path);
    });
    audios = fetechedAudios;
    newPlaylist = Playlist(audios: audios);
  }

  List<Audio> audioList = [];

  void setUp() async {
    controller = Provider.of<SongController>(context, listen: false);
    await controller.setUpPlaylist(songCategory: SongCategory.allTracks);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUp();
  }

  @override
  Widget build(BuildContext context) {
    //final controller = Provider.of<SongController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FutureBuilder(
            future: FlutterAudioQuery()
                .getSongs(sortType: SongSortType.DISPLAY_NAME),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<SongInfo> songInfo = snapshot.data;

                return ListView.separated(
                  padding: EdgeInsets.all(0.0),
                  physics: BouncingScrollPhysics(),
                  itemCount: songInfo.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 3,
                    color: Colors.grey,
                  ),
                  // ignore: missing_return
                  itemBuilder: (context, index) {
                    SongInfo song = songInfo[index];
                    if (song.displayName.contains(".mp3")) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(0.0),
                        onTap: () {
                          //assetsAudioPlayer.next(keepLoopMode: false);
                          //assetsAudioPlayer.next(keepLoopMode: false);
                          //assetsAudioPlayer.play();
                          controller.play(index: index);
                        },
                        leading: PlayButton(
                          onTap: () async {
                            //controller.play(index: index);
                            //controller.next();
                            print("jhgfdsdfghjkjhgfdfghjkjhgf");
                            //assetsAudioPlayer.open(newPlaylist);
                            //print(newPlaylist);
                            //newPlaylist.add(Audio.file(song.filePath));
                            //assetsAudioPlayer.open(Audio.file(song.filePath));
                          },
                        ),
                        title: Text(
                          song.title,
                          maxLines: 1,
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        subtitle: Text(
                          song.artist,
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                        trailing: getPopUp(),
                      );
                    }
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }

  Widget getPopUp() => PopupMenuButton(
        color: kBackGroundColor,
        itemBuilder: (context) {
          return CustomPopUpItem.trackPopUpItem().map((CustomPopUpItem e) {
            return PopupMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    e.icon,
                    size: 12.0,
                    color: Colors.grey,
                  ),
                  //SizedBox(width: 10.0,),
                  Text(
                    e.title,
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  )
                ],
              ),
            );
          }).toList();
        },
        child: ImageIcon(
          AssetImage("assets/icons/icons8_menu_vertical_16px.png"),
          color: Colors.white,
        ),
      );
}
