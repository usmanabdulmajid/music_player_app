import 'dart:io';

import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicplayerapp/models/custom_popup_item.dart';
import 'package:musicplayerapp/models/song.dart';
import 'package:musicplayerapp/utils/constant_colors.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:musicplayerapp/widgets/play_button.dart';
// ignore: must_be_immutable
class TrackScreen extends StatefulWidget {
  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  bool _isPlaying;
  double _slider;
  var audioManagerInstance = AudioManager.instance;
  FlutterAudioQuery flutterAudioQuery = FlutterAudioQuery();


  List<Song> songs = getSongs();
  int indexSelected;

  void setupAudio() async {
    List<SongInfo> tracks;
    List<AudioInfo> _list = [];
    Future<List<SongInfo>> allSongs;
    allSongs = flutterAudioQuery.getSongs(sortType: SongSortType.DISPLAY_NAME);
    tracks = await allSongs;
    /*allSongs.then((value) {
      if(value != null){
        value.forEach((element) {
          setState(() {
            tracks.add(element);
          });
        });
      }
    });*/
    //print(allSongs);
    //print("yjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhmmmmmmmmmmm $tracks");
    tracks.forEach((element) {
      _list.add(AudioInfo(element.uri,
        title: element.title,
        desc: element.displayName,
        coverUrl: element.albumArtwork,
      ));
    });
    AudioManager.instance.audioList = _list;
    AudioManager.instance.intercepter = true;
    AudioManager.instance.play(auto: false);

    AudioManager.instance.onEvents((events, args) {
      print("$events, $args");
      switch (events) {
        case AudioManagerEvents.start:
          print(
              "start load data callback, curIndex is ${AudioManager.instance.curIndex}");
          //_position = AudioManager.instance.position;
          //_duration = AudioManager.instance.duration;
          _slider = 0;
          setState(() {});
          break;
        case AudioManagerEvents.ready:
          print("ready to play");
          //_error = null;
          //_sliderVolume = AudioManager.instance.volume;
          //_position = AudioManager.instance.position;
          //_duration = AudioManager.instance.duration;
          setState(() {});
          // if you need to seek times, must after AudioManagerEvents.ready event invoked
          // AudioManager.instance.seekTo(Duration(seconds: 10));
          break;
        case AudioManagerEvents.seekComplete:
          //_position = AudioManager.instance.position;
          //_slider = _position.inMilliseconds / _duration.inMilliseconds;
          setState(() {});
          print("seek event is completed. position is [$args]/ms");
          break;
        case AudioManagerEvents.buffering:
          print("buffering $args");
          break;
        case AudioManagerEvents.playstatus:
          //isPlaying = AudioManager.instance.isPlaying;
          setState(() {});
          break;
        case AudioManagerEvents.timeupdate:
          //_position = AudioManager.instance.position;
          //_slider = _position.inMilliseconds / _duration.inMilliseconds;
          setState(() {});
          AudioManager.instance.updateLrc(args["position"].toString());
          break;
        case AudioManagerEvents.error:
          print("the erroro is that its not ----- $args");
          //_error = args;

          setState(() {});
          break;
        case AudioManagerEvents.ended:
          AudioManager.instance.next();
          break;
        case AudioManagerEvents.volumeChange:
          //_sliderVolume = AudioManager.instance.volume;
          setState(() {});
          break;
        default:
          break;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //setupAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FutureBuilder(
            future: FlutterAudioQuery().getSongs(sortType: SongSortType.DISPLAY_NAME),
            // ignore: missing_return
            builder: (context, snapshot){
              List<SongInfo> songInfo = snapshot.data;
              if(snapshot.hasData){

                return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemCount: songInfo.length,
                  separatorBuilder: (context, index) => Divider(height: 3, color: Colors.grey,),
                  // ignore: missing_return
                  itemBuilder: (context, index){
                    SongInfo song = songInfo[index];
                    if(song.displayName.contains(".mp3")){
                      return ListTile(
                        onTap: ()  {
                          print("this is the supposed file path: ${song.filePath}");
                          //create a new player
                          AudioPlayer audioPlayer = AudioPlayer();
                          String fl = "file://" + song.filePath;
                          audioPlayer.play(fl, isLocal: true);

                        },
                        title: Text(song.title, maxLines: 1, style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0
                        ),),
                        subtitle: Text(song.artist, style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0
                        ),),
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
    itemBuilder: (context){
      return CustomPopUpItem.trackPopUpItem().map(( CustomPopUpItem e) {
        return PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(e.icon, size: 12.0, color: Colors.grey,),
              //SizedBox(width: 10.0,),
              Text(e.title, style: TextStyle(
                color: Colors.white,
                fontSize: 12.0
              ),)
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

  Future<String> getSongPath(String uri) async {
    Directory directory =  await getExternalStorageDirectory();
    String pth = directory.path + uri;
    return pth;
  }


}