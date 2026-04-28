import 'package:melon_sdk/song/song.dart';

abstract interface class SongSource {
  Future<List<Song>> pullSongs();

  void pushSong(Song song) {}
}