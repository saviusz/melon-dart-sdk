import 'dart:async';

import 'empty_song_title_exception.dart';
import 'song.dart';
import 'song_list_event.dart';

class SongService {

  final List<Song> _songs = [];
  final _eventBus = StreamController<SongListEvent>.broadcast();

  Future<String> createSong({required String title}) async {
    
    if (title.isEmpty) {
      throw EmptySongTitleException();
    }
    
    final id = "";
    final song = Song(id: id, title: title);

    _songs.add(song);
    _eventBus.add(SongCreated(song: song));
    
    return id;
  }

  Stream<List<Song>> viewSongs() async* {
    yield _songs;
    await for (final event in _eventBus.stream) {
      if (event case SongCreated _) {
        yield _songs;
      }
    }
  }

  Future<List<Song>> getSongs() async {
    return _songs;
  }
}