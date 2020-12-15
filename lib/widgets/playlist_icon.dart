import 'package:flutter/material.dart';

class PlayListIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ImageIcon(
        AssetImage("assets/icons/icons8_playlist_24px.png"),
      ),
    );
  }
}
