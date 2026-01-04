import 'package:melon_core/artists/artist_service.dart';
import 'package:melon_core/songs/song_service.dart';

class MelonCore {
  MelonCore({required this.songService, required this.artistService});

  final SongService songService;
  final ArtistService artistService;
}
