import 'package:melon_core/artists/artist_service.dart';
import 'package:melon_core/songs/song_service.dart';

class MelonCore  {

  final SongService _songService = SongService();
  final ArtistService _artistService = ArtistService();

  get songService => _songService;
  get artistService => _artistService;
}
