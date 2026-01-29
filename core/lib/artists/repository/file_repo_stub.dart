import 'package:melon_core/artists/artist.dart';
import 'package:melon_core/artists/repository/artist_repository.dart';
import 'package:melon_core/misc/exception.dart';

class FileArtistRepository implements ArtistRepository {
  
  FileArtistRepository(String basePath) {
    throw MelonException("Platform not supported");
  }
  
  @override
  Stream<Artist> create(Artist artist) {
    throw MelonException("Platform not supported");
  }

  @override
  Stream<Artist> get(String id) {
    throw MelonException("Platform not supported");
  }

  @override
  Stream<bool> has(String id) {
    throw MelonException("Platform not supported");
  }

  @override
  Stream<List<Artist>> list() {
    throw MelonException("Platform not supported");
  }
  
}