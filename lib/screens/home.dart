import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicplayerapp/screens/play_list_screen.dart';
import 'package:musicplayerapp/screens/track_screen.dart';
import 'package:musicplayerapp/utils/constant_colors.dart';

import 'album_screen.dart';
import 'artist_screen.dart';
import 'favorite_screen.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  TabController _controller;

  List<Tab> myTabs = <Tab>[
    Tab(
      child: Icon(Icons.favorite, color: Colors.red,),
    ),
    Tab(
      child: Text("Tracks", style: TextStyle(
        color: Colors.grey,
      ),),
    ),
    Tab(
      child: Text("Playlists", style: TextStyle(
        color: Colors.grey,
      ),),
    ),
    Tab(
      child: Text("Album", style: TextStyle(
        color: Colors.grey
      ),),
    ),
    Tab(
      child: Text("Artists", style: TextStyle(
        color: Colors.grey,
      ),),
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 5, vsync: this, initialIndex: 1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: Container(
        padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  iconSize: 30.0,
                  color: Colors.blue,
                  icon: Icon(Icons.search),
                  onPressed: (){

                  },
                ),
                SizedBox(width: 10.0,),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.menu_outlined),
                  onPressed: (){

                  },
                )
              ],
            ),
            SizedBox(height: 10.0,),
            Container(
              height: 38.0,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                  top: BorderSide(color: Colors.grey),
                ),
              ),
              child: TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
                controller: _controller,
                unselectedLabelColor: Colors.orange,
                indicatorPadding: EdgeInsets.only(left: 5.0),
                indicatorWeight: 2.0,
                labelColor: Colors.white,
                tabs: myTabs,
                onTap: (int a){

                },
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  FavoriteScreen(),
                  TrackScreen(),
                  PlayListScreen(),
                  AlbumScreen(),
                  ArtistScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
