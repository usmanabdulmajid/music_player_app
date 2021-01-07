import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicplayerapp/utils/song_category.dart';

class SongController extends ChangeNotifier {
  FlutterAudioQuery flutterAudioQuery;
  AssetsAudioPlayer player;
  bool isPlaying = false;
  int currentTime = 0;
  int songLength = 0;
  Duration currentSongDuration;
  Audio currentPlayingSong;
  //List<SongInfo> songs = [];
  Playlist playlist;
  String timeCollapsed = "";
  String totalLength = "";

  Future<void> setUpPlaylist(
      {@required SongCategory songCategory,
      String id,
      PlaylistInfo playlistInfo}) async {
    flutterAudioQuery = FlutterAudioQuery();

    var songs = await getSongs(
        songCategory: songCategory, id: id, playlistInfo: playlistInfo);
    print(songs.length);
    var audios = <Audio>[];
    var fetchedSongs = songs.map((e) {
      return Audio.file(e.filePath,
          metas: Metas(
            artist: e.artist,
            album: e.album,
            //image: MetasImage.asset("assets/images/country.jpg"),
            title: e.title,
          ));
    }).toList();
    audios = fetchedSongs;
    player = AssetsAudioPlayer();
    playlist = Playlist(audios: audios, startIndex: 0);
    currentSongDuration = player.currentPosition.value;
    //currentPlayingSong = player.current.value.audio.audio;
    player.current.listen((event) {
      var dur = event.audio.duration;
      totalLength = "${dur.inMinutes}:${dur.inSeconds % 60}";
    });
    getCurrentPosition();
  }

  void getCurrentPosition() {
    player.currentPosition.listen((event) {
      currentTime = event.inSeconds;
      timeCollapsed = "${event.inMinutes}:${event.inSeconds % 60}";
      notifyListeners();
    });
  }

  // ignore: missing_return
  Future<List<SongInfo>> getSongs(
      {@required SongCategory songCategory,
      String id,
      PlaylistInfo playlistInfo}) async {
    switch (songCategory) {
      case SongCategory.allTracks:
        return await flutterAudioQuery.getSongs(
            sortType: SongSortType.DISPLAY_NAME);
        break;
      case SongCategory.albumTracks:
        return await flutterAudioQuery.getSongsFromAlbum(
            albumId: id, sortType: SongSortType.DISPLAY_NAME);
        break;
      case SongCategory.artistTracks:
        return await flutterAudioQuery.getSongsFromArtist(
            artistId: id, sortType: SongSortType.DISPLAY_NAME);
        break;
      case SongCategory.playlistTracks:
        if (playlistInfo.name != "favorite") {
          return await flutterAudioQuery.getSongsFromPlaylist(
              playlist: playlistInfo);
        }
        break;
      default:
        return await flutterAudioQuery.getSongs(
            sortType: SongSortType.DISPLAY_NAME);
        break;
    }
  }

  Future<void> play({int index}) async {
    playlist.startIndex = index;
    await player.open(playlist);
    print(player.playlist.audios);
    setIsPlaying(true);
  }

  void setIsPlaying(bool value) {
    isPlaying = value;
    notifyListeners();
  }

  Future<void> next() async {
    player.next();
  }

  Future<void> prev() async {
    player.previous();
  }

  Future<void> pause() async {
    player.pause();
    setIsPlaying(false);
  }

  Future<void> seek(position) async {
    await player.seek(Duration(seconds: currentTime + position.toInt()));
  }
}
