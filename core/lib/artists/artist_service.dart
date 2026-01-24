import 'package:melon_core/artists/artist.dart';
import 'package:melon_core/artists/artist_repository.dart';
import 'package:melon_core/misc/snapshot.dart';

class ArtistService {
  ArtistService({
    required ArtistRepository repo,
  }) : _artists = repo;

  final ArtistRepository _artists;

  Stream<Snapshot<List<ArtistRecord>>> getAllArtists() async* {
    yield* _artists.list();
  }

  Stream<Snapshot<ArtistRecord>> createArtist({
    String? name,
    String? surname,
    String? pseudonym,
  }) async* {
    final artist = ArtistRecord(
      id: '---id---',
      name: name,
      surname: surname,
      pseudonym: pseudonym,
    );

    yield* _artists.add(artist);
  }

  Stream<Snapshot<ArtistRecord>> getArtistById(String id) async* {
    yield* _artists.get(id);
  }
}
