import 'dart:async';

import 'artist.dart';
import 'artist_list_event.dart';
import 'artist_exceptions.dart';

class ArtistService {

  final _eventBus = StreamController<ArtistListEvent>.broadcast();
  final _artists = <Artist>[];

  ArtistService();

  Future<String> createArtist({String? name, String? surname, String? pseudonym}) async {
    
    if (
      (name == null || name.isEmpty) &&
      (surname == null || surname.isEmpty) &&
      (pseudonym == null || pseudonym.isEmpty)
    ) {
      throw EmptyArtistNameException();
    }
    
    final id = "";
    final artist = Artist(id: id, name: name, surname: surname, pseudonym: pseudonym);
    
    _artists.add(artist);
    _eventBus.add(ArtistCreated(artist));
    
    return id;
  }

  Future<List<Artist>> getArtists() async {
    return List.unmodifiable(_artists);
  }

  Stream<List<Artist>> viewArtists() async* {
    yield await getArtists();
    await for (final event in _eventBus.stream) {
      if (event case ArtistCreated _) {
        yield await getArtists();
      }
    }
  }

  Future<Artist> getArtist(String authorId) async {
    final index = _artists.indexWhere((artist) => artist.id == authorId);
    if (index == -1) {
      throw ArtistNotFoundException();
    }
    return _artists[index];
  }

}