import 'package:melon_sdk/song/song.dart';

class SongCache {
  final List<Song> _songs = [];

  List<Song> getSongs([bool Function(Song)? filter]) =>
      _songs.where(filter ?? (_) => true).toList();

  Song? getSong([bool Function(Song)? predicate]) => getSongs(predicate).firstOrNull;

  void putSongs(List<Song> songs) {
    for (final song in songs) putSong(song);
  }

  void putSong(Song song) {
    final index = _songs.indexWhere((s) => s.id == song.id);
    if (index != -1) _songs[index] = song;
    else _songs.add(song);
  }
}
