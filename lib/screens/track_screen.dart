import 'package:flutter/material.dart';
import 'package:musicplayerapp/models/song.dart';
import 'package:musicplayerapp/utils/constant_colors.dart';
import 'package:musicplayerapp/widgets/play_button.dart';
// ignore: must_be_immutable
class TrackScreen extends StatefulWidget {
  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  bool _isPlaying = false;

  List<Song> songs = getSongs();
  int indexSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemCount: songs.length,
            separatorBuilder: (context, index) => Divider(height: 3, color: Colors.grey,),
            itemBuilder: (context, index){
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
                title: Text(songs[index].songTitle, style: TextStyle(
                  color: Colors.white,
                ),),
                subtitle: Text(songs[index].artistName, style: TextStyle(
                  color: Colors.white,
                ),),
              );
            },
          ),
        ),
      ],
    );
  }
}
