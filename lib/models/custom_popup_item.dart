import 'package:flutter/material.dart';

class CustomPopUpItem{
  IconData icon;
  String title;
  CustomPopUpItem({this.icon, this.title});

  static List<CustomPopUpItem> trackPopUpItem(){
    return [
      CustomPopUpItem(icon: Icons.playlist_add, title: "Add to playlist"),
      CustomPopUpItem(icon: Icons.favorite, title: "Add to Favorite"),
      CustomPopUpItem(icon: Icons.share, title: "Share song"),
      CustomPopUpItem(icon: Icons.delete, title: "Delete song")
    ];
  }
}