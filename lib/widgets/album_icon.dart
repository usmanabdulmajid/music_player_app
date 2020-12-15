import 'package:flutter/material.dart';

class AlbumIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey,
      ),
      child: ImageIcon(
        AssetImage("assets/icons/icons8_music_record_64px.png"),
      ),
    );
  }
}
