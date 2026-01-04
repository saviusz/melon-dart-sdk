import 'package:melon_core/songs/song.dart';

class SongService {
  
  final List<Song> _songs = [];
  Song createSong({required String title}) {
    if (title.isEmpty) {
      throw Exception('Title cannot be empty');
    }

    if (_songs.any((song) => song.title == title)) {
      throw Exception('Song already exists');
    }

    final song = Song(id: '---id---', title: title);
    _songs.add(song);
    return song;
  }

  Song getSongById(String id) {
    try {
      final song = _songs.firstWhere((song) => song.id == id);
      return song;
    } catch (e) {
      throw Exception('Song not found');
    }
  }

  List<Song> getAllSongs() {
    return _songs.toList();
  }

}
