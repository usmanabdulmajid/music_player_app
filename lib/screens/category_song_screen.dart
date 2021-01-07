import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicplayerapp/models/custom_popup_item.dart';
import 'package:musicplayerapp/providers/song_controller.dart';
import 'package:musicplayerapp/utils/constant_colors.dart';
import 'package:musicplayerapp/utils/song_category.dart';
import 'package:musicplayerapp/widgets/play_button.dart';
import 'package:provider/provider.dart';

class CategorySongScreen extends StatefulWidget {
  final Future<List<DataModel>> dataModel;
  //final SongCategory songCategory;
  //final String id;
  //final PlaylistInfo playlist;

  const CategorySongScreen({Key key, this.dataModel}) : super(key: key);
  @override
  _CategorySongScreenState createState() => _CategorySongScreenState();
}

class _CategorySongScreenState extends State<CategorySongScreen> {
  final Future<List<DataModel>> dataModel;
  //final SongCategory songCategory;
  //final String id;
  //final PlaylistInfo playlist;
  _CategorySongScreenState({this.dataModel});

  //SongController controller;

  /**void setUp() async {
    controller = Provider.of<SongController>(context, listen: false);
    if (songCategory == SongCategory.albumTracks) {
      await controller.setUpPlaylist(
          songCategory: SongCategory.albumTracks, id: id);
    } else if (songCategory == SongCategory.artistTracks) {
      await controller.setUpPlaylist(
          songCategory: SongCategory.artistTracks, id: id);
    } else if (songCategory == SongCategory.playlistTracks) {
      await controller.setUpPlaylist(
          songCategory: SongCategory.playlistTracks, playlistInfo: playlist);
    }
  }**/

  @override
  void initState() {
    // TODO: implement initState
    //setUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: kBackGroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder(
                future: dataModel,
                builder: (context, snapshot) {
                  List<SongInfo> songList = snapshot.data;
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: songList.length,
                      itemBuilder: (context, index) {
                        SongInfo song = songList[index];
                        return ListTile(
                          leading: PlayButton(
                            onTap: () {
                              //controller.play(index: index);
                            },
                          ),
                          title: Text(
                            song.title,
                            maxLines: 1,
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                          subtitle: Text(
                            song.artist,
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                          trailing: getPopUp(),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
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
