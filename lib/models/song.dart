class Song{
  String artistName;
  String songTitle;

  Song({this.artistName, this.songTitle});
}

List<Song> getSongs(){
  List<Song> songs = List<Song>();
  Song song = Song();
  //1
  song.songTitle = "3 AM";
  song.artistName = "NF";
  songs.add(song);
  //2
  song = Song();
  song.songTitle = "Real";
  song.artistName = "NF";
  songs.add(song);
  //3
  song = Song();
  song.songTitle = "Oh Lord";
  song.artistName = "NF";
  songs.add(song);
  //4
  song = Song();
  song.songTitle = "Therapy Session";
  song.artistName = "NF";
  songs.add(song);
  //5
  song = Song();
  song.songTitle = "How Could You Leave";
  song.artistName = "NF";
  songs.add(song);
  //6
  song = Song();
  song.songTitle = "Motivated";
  song.artistName = "NF";
  songs.add(song);
  //7
  song = Song();
  song.songTitle = "Change";
  song.artistName = "NF";
  songs.add(song);
  //8
  song = Song();
  song.songTitle = "Only Me";
  song.artistName = "NF";
  songs.add(song);
  //9
  song = Song();
  song.songTitle = "Mansion";
  song.artistName = "NF";
  songs.add(song);
  //10
  song = Song();
  song.songTitle = "Leave Me Alone";
  song.artistName = "NF";
  songs.add(song);

  return songs;
}