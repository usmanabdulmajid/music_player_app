import 'package:flutter/material.dart';


final kBackGroundColor = _getColorFromHex("#2D2C35");

final kPlayTileBackGround = _getColorFromHex("#272626");

// ignore: missing_return
Color _getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }
}