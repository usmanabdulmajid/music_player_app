import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
class ArtistScreen extends StatefulWidget {
  @override
  _ArtistScreenState createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  FlutterAudioQuery flutterAudioQuery = FlutterAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FutureBuilder(
            future: flutterAudioQuery.getArtists(),
            // ignore: missing_return
            builder: (context , snapshot){
              List<ArtistInfo> artistList = snapshot.data;
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: artistList.length,
                  itemBuilder: (context, index){
                    ArtistInfo artistInfo = artistList[index];
                    return ListTile(
                      contentPadding: EdgeInsets.all(0.0),
                      onTap: (){

                      },
                      leading:(artistInfo.artistArtPath != null) ? Image.file(File(artistInfo.artistArtPath)) :
                      FutureBuilder(
                        future: flutterAudioQuery.getArtwork(type: ResourceType.ARTIST, id: artistInfo.id),
                        builder: (context, snapshot){
                          if(snapshot.data == null){
                            return CircleAvatar(
                              backgroundColor: Colors.transparent,
                            );
                          }
                          return ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(200)),
                            child: Image.memory(snapshot.data,
                              fit: BoxFit.cover,
                              width: 45.0,
                              height: 45.0,
                              errorBuilder: (context, o, n){
                              return ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(200)),
                                child: Image.asset("assets/images/person-icon-8.png",
                                  height: 49.0,
                                  width: 49.0,
                                  fit: BoxFit.cover,
                                ),
                              );
                              },
                            ),
                          );
                        },
                      ),

                      title: Text(artistInfo.name, maxLines: 1, style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white
                      ),),
                      subtitle: Text(artistInfo.numberOfTracks, maxLines: 1, style: TextStyle(
                        color: Colors.white,
                      ),),
                      trailing: IconButton(
                        onPressed: (){

                        },
                        icon: ImageIcon(
                          AssetImage("assets/icons/icons8_menu_vertical_16px.png"),
                          color: Colors.white,
                          size: 28.0,
                        ),
                      ),
                    );
                  },
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
