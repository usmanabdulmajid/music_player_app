import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicplayerapp/utils/constant_colors.dart';

class SongDetailScreen extends StatefulWidget {
  final AssetsAudioPlayer player;
  final SongInfo song;

  const SongDetailScreen({Key key, this.player, this.song}) : super(key: key);
  @override
  _SongDetailScreenState createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen> {
  final AssetsAudioPlayer player;
  final SongInfo song;

  _SongDetailScreenState({this.player, this.song});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: Container(
        padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              height: 300.0,
              //width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                color: Colors.white,
              ),
            ),
            Text(
              "Paralysed",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25.0),
            ),
            Text(
              "NF",
              style:
                  TextStyle(color: Colors.white, fontSize: 16.0, height: 2.0),
            ),
            Slider(
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
              value: 2.0,
              min: 0.0,
              max: 4.0,
              onChanged: (double newValue) {},
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "0:00",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "4:23",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  icon: Icons.shuffle,
                  onPressed: () {},
                ),
                CustomButton(
                  icon: Icons.skip_previous,
                  onPressed: () {},
                ),
                CustomButton(
                  width: 63.0,
                  height: 63.0,
                  icon: Icons.pause,
                  onPressed: () {},
                ),
                CustomButton(
                  icon: Icons.skip_next,
                  onPressed: () {},
                ),
                CustomButton(
                  icon: Icons.repeat,
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final double width;
  final double height;

  const CustomButton(
      {this.onPressed, this.icon, this.height = 40.0, this.width = 40.0});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: width,
        height: height,
      ),
      shape: CircleBorder(),
      fillColor: kBackGroundColor,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
