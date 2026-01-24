import 'artist.dart';

abstract interface class ArtistSource {
  Future<ArtistRecord> get(String id);
  Future<List<ArtistRecord>> list();
  Future<ArtistRecord> add(ArtistRecord artist);
}
