import 'package:melon_core/artists/repository/artist_repository.dart';

import '../artist.dart';
import 'exceptions.dart';

class ArtistService {

  ArtistService(ArtistRepository artists) : _artists = artists; 
  
  final ArtistRepository _artists;
  
  Stream<List<Artist>> getAllArtists() async* {
    yield* _artists.list();
  }

  Stream<Artist> createArtist({
    String? name,
    String? surname,
    String? pseudonym,
  }) async* {

    if (
      (name == null || name.isEmpty)
      && (surname == null || surname.isEmpty)
      && (pseudonym == null || pseudonym.isEmpty)
    ) {
      throw ArtistMissingDataException();
    }

    final count = (await _artists.list().first).length;

    final artist = Artist(
      id: count.toString(),
      name: name,
      surname: surname,
      pseudonym: pseudonym,
    );

    yield* _artists.create(artist);
  }

  Stream<Artist> getArtistById(String id) async* {
    yield* _artists.get(id);
  }

}