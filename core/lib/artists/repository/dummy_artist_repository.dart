import 'package:melon_core/artists/artist.dart';
import 'package:melon_core/artists/repository/artist_repository.dart';
import 'package:melon_core/artists/service/exceptions.dart';

class DummyArtistRepository extends ArtistRepository {

  final List<Artist> artists;

  DummyArtistRepository([artists]) : artists = artists ?? [];

  @override
  Stream<Artist> create(Artist artist) async* {
    this.artists.add(artist);
    yield artist;
  }

  @override
  Stream<Artist> get(String id) async* {
    final index = this.artists.indexWhere((artist) => artist.id == id);
    if (index == -1) {
      throw ArtistNotFoundException(id);
    }

    yield this.artists[index];
  }

  @override
  Stream<bool> has(String id) async* {
    final index = this.artists.indexWhere((artist) => artist.id == id);
    yield index != -1;
  }

  @override
  Stream<List<Artist>> list() async* {
    yield this.artists;
  }
}