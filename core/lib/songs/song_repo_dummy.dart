import 'package:melon_core/songs/song.dart';
import 'package:melon_core/songs/song_repository.dart';

class SongRepoDummy extends SongRepository {
  final List<Song> _songs = [];

  @override
  Future<List<Song>> list(bool Function(Song)? filter) async {
    return _songs;
  }

  @override
  Future<Song?> get(bool Function(Song) filter) async {
    try {
      return _songs.firstWhere(filter);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> has(bool Function(Song) filter) async {
    return _songs.any(filter);
  }

  @override
  Future<void> save(Song item) async {
    _songs.add(item);
  }
}
