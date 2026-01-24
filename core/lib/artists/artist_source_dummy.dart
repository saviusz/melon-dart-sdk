import 'package:melon_core/artists/artist.dart';
import 'package:melon_core/artists/artist_source.dart';
import 'package:melon_core/misc/exception.dart';

class ArtistSourceDummy implements ArtistSource {

  ArtistSourceDummy([List<ArtistRecord> artists = const []]) : _artists = artists;

  List<ArtistRecord> _artists;
  
  @override
  Future<ArtistRecord> get(String id) async {
    try {
      return _artists.firstWhere((artist) => artist.id == id);
    } catch (e) {
      throw MelonException('Artist not found', e as Exception?);
    }
  }

  @override
  Future<List<ArtistRecord>> list() {
    return Future.value(_artists);
  }
  
  @override
  Future<ArtistRecord> add(ArtistRecord artist) {
    _artists.add(artist);
    return Future.value(artist);
  }
  
}