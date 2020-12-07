import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicplayerapp/models/song.dart';
import 'package:musicplayerapp/utils/constant_colors.dart';
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

  List<Song> songs = getSongs();
  int indexSelected;

  void setupAudio() {
    audioManagerInstance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.start:
          _slider = 0;
          break;
        case AudioManagerEvents.seekComplete:
          _slider = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          setState(() {

          });
          break;
        case AudioManagerEvents.playstatus:
          _isPlaying = audioManagerInstance.isPlaying;
          setState(() {

          });
          break;
        case AudioManagerEvents.timeupdate:
          _slider = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          audioManagerInstance.updateLrc(args["position"].toString());
          setState(() {

          });
          break;
        case AudioManagerEvents.ended:
          audioManagerInstance.next();
          setState(() {

          });
          break;
        default:
          break;
      }
    });
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
                        leading: PlayButton(
                          selectedIndex: indexSelected,
                          index: index,
                          onTap: (){
                            setState(() {
                              indexSelected = index;
                            });
                          },
                          isPlaying: _isPlaying,
                        ),
                        title: Text(song.title, maxLines: 1, style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0
                        ),),
                        subtitle: Text(song.artist, style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0
                        ),),
                        trailing: IconButton(
                          iconSize: 28.0,
                          color: Colors.blue,
                          onPressed: (){

                          },
                          icon: Icon(Icons.playlist_add),
                        ),
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
}
