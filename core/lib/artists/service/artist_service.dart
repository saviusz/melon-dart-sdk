import '../artist.dart';
import 'exceptions.dart';

class ArtistService {

  ArtistService([List<Artist>? artists]) : _artists = artists ?? []; 
  
  final List<Artist> _artists;
  
  Stream<List<Artist>> getAllArtists() async* {
    yield _artists.toList();
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

    final artist = Artist(
      id: '---id---',
      name: name,
      surname: surname,
      pseudonym: pseudonym,
    );

    _artists.add(artist);
    yield artist;
  }

  Stream<Artist> getArtistById(String id) async* {
    final index = _artists.indexWhere((artist) => artist.id == id);
    if (index == -1) {
      throw ArtistNotFoundException(id);
    } else {
      final artist = _artists[index];
      yield artist;
    }
  }

}