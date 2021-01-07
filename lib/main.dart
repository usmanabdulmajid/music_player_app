import 'package:flutter/material.dart';
import 'package:musicplayerapp/providers/song_controller.dart';
import 'package:musicplayerapp/screens/detail_screen.dart';
import 'package:musicplayerapp/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SongController()),
      ],
      child: MatApp(),
    );
  }
}

class MatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music player',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}
