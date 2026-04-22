import 'dart:async';

import 'package:melon_sdk/artist/index.dart';
import 'package:melon_sdk/util/id/id.dart';
import 'package:melon_sdk/util/id/id_generator.dart';

import 'expections.dart';
import 'song.dart';
import 'song_list_event.dart';

class SongService {

  SongService({required this.artists, required IdGenerator idGenerator}) : _idGenerator = idGenerator;

  final ArtistService artists;
  final IdGenerator _idGenerator;

  final _eventBus = StreamController<SongListEvent>.broadcast();
  
  final List<Song> _songs = [];
  


  Future<void> dispose() async {
    await _eventBus.close();
  }

  Future<ID> createSong({required String title}) async {
    
    if (title.isEmpty) {
      throw EmptySongTitleException();
    }
    
    final id = _idGenerator.generate();
    final song = Song(id: id, title: title);

    _songs.add(song);
    _eventBus.add(SongCreated(song: song));
    
    return id;
  }

  Stream<List<Song>> viewSongs() async* {
    yield List.unmodifiable(_songs);
    await for (final event in _eventBus.stream) {
      if (event case SongCreated _) {
        yield List.unmodifiable(_songs);
      }
    }
  }

  Future<List<Song>> getSongs() async {
    return _songs;
  }

  Future<void> assignAuthor(ID songId, ID authorId) async {
    final currentIndex = _songs.indexWhere((song) => song.id == songId);

    if (currentIndex == -1) {
      throw SongNotFoundException();
    }

    final currentSong = _songs.elementAt(currentIndex);
    final newSong = currentSong.withAuthor(authorId);

    final artist = await artists.getArtist(authorId);

    _songs[currentIndex] = newSong;

    this._eventBus.add(AuthorAssigned(artist: artist, song: newSong));
  }

  Future<void> assignPerformer(ID songId, ID performerId) async {
    final currentIndex = _songs.indexWhere((song) => song.id == songId);

    if (currentIndex == -1) {
      throw SongNotFoundException();  
    }

    final currentSong = _songs.elementAt(currentIndex);
    final newSong = currentSong.withPerformer(performerId);

    final artist = await artists.getArtist(performerId);

    _songs[currentIndex] = newSong;
    this._eventBus.add(PerformerAssigned(artist: artist, song: newSong));
  }

  Future<Object?> getSong(ID songId) async {
    final index = _songs.indexWhere((song) => song.id == songId);
    if (index == -1) {
      throw SongNotFoundException();
    }
    return _songs.elementAt(index);
  }
}
