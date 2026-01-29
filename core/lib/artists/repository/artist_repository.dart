import 'package:melon_core/artists/artist.dart';

abstract class ArtistRepository {

  Stream<Artist> create(Artist artist);
  Stream<List<Artist>> list();
  Stream<Artist> get(String id);
  Stream<bool> has(String id);

}