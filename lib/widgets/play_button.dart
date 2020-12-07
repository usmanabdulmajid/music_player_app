import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  bool isPlaying;
  Function onTap;
  int selectedIndex;
  int index;
  PlayButton({this.isPlaying, this.onTap, this.selectedIndex, this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.0,
      height: 45.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(200),
        ),
        border: Border.all(color: Colors.white),
      ),
      child: FlatButton(
        onPressed: onTap,
        child: selectedIndex == index ? Icon(Icons.play_arrow) : Icon(Icons.pause),
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(200),
          )
        ),
      ),
    );
  }
}
