import 'package:melon_core/songs/song.dart';
import 'package:melon_core/songs/song_repository.dart';

class SongService {
  final SongRepository repo;

  SongService({required this.repo});

  Future<Song> createSong({required String title}) async {
    if (title.isEmpty) {
      throw Exception('Title cannot be empty');
    }

    if (await repo.has((song) => song.title == title)) {
      throw Exception('Song already exists');
    }

    final song = Song(id: '---id---', title: title);
    repo.save(song);
    return song;
  }

  Future<Song> getSongById(String id) async {
    final song = await repo.get((song) => song.id == id);
    if (song == null) {
      throw Exception('Song not found');
    }
    return song;
  }

  Future<List<Song>> getAllSongs() async {
    return repo.list(null);
  }
}
