import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
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
            future: flutterAudioQuery.getAlbums(sortType: AlbumSortType.ALPHABETIC_ARTIST_NAME),
            // ignore: missing_return
            builder: (context, snapshot){
              List<AlbumInfo> albumList = snapshot.data;
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: albumList.length,
                  itemBuilder: (context, index){
                    AlbumInfo albumInfo = albumList[index];
                    return ListTile(
                      contentPadding: EdgeInsets.all(0.0),
                      onTap: (){

                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: albumInfo.albumArt == null ? Image.asset("assets/images/kelly-sikkema-HwU5H9Y6aL8-unsplash.jpg") :
                        Image(
                          height: 40.0,
                          width: 30.0,
                          fit: BoxFit.cover,
                          image: FileImage(File(albumInfo.albumArt)),
                        ),
                      ),
                      title: Text(albumInfo.title, maxLines: 1, style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),),
                      subtitle: Text(albumInfo.artist,maxLines: 1, style: TextStyle(
                        color: Colors.white,
                      ),),
                      trailing: IconButton(
                        onPressed: (){

                        },
                        icon: ImageIcon(
                          AssetImage("assets/icons/icons8_menu_vertical_16px.png"),
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                );
              }
              return Container(width: 0.0, height: 0.0,);
            },
          ),
          ),
      ],
    );
  }
}
