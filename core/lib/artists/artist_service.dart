import 'package:melon_core/artist.dart';

class ArtistService {
  
  final List<Artist> _artists = [];
  
  List<Artist> getAllArtists() {
    return _artists.toList();
  }

  Artist createArtist({
    String? name,
    String? surname,
    String? pseudonym,
  }) {
    final artist = Artist(
      id: '---id---',
      name: name,
      surname: surname,
      pseudonym: pseudonym,
    );
    _artists.add(artist);
    return artist;
  }

  Artist getArtistById(String id) {
    try {
      final artist = _artists.firstWhere((artist) => artist.id == id);
      return artist;
    } catch (e) {
      throw Exception('Artist not found');
    }
  }

}