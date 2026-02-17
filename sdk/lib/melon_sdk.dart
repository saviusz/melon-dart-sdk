import 'package:melon_core/artists/repository/artist_repository.dart';
import 'package:melon_core/artists/repository/file_repo.dart';
import 'package:melon_core/artists/service/artist_service.dart';
import 'package:melon_core/songs/song_repo_dummy.dart';
import 'package:melon_core/songs/song_repository.dart';
import 'package:melon_core/songs/song_service.dart';

class MelonSdk {
  
  MelonSdk(){
    _init();
  }

  late ArtistRepository _artistRepository;
  late SongRepository _songRepository;

  late ArtistService _artistService;
  late SongService _songService;

  void _init() {
    _initArtistRepository();
    _initSongRepository();
  }

  void _initArtistRepository() {
    _artistRepository = FileArtistRepository("./run/artists");
    _initArtistService();
  }
  
  void _initSongRepository() {
    _songRepository = SongRepoDummy();
    _initSongService();
  }
  
  void _initSongService() {
    _songService = SongService(repo: _songRepository);
  }

  void _initArtistService() {
    _artistService = ArtistService(_artistRepository);
  }

  ArtistService get artistService => _artistService;
  SongService get songService => _songService;
}
