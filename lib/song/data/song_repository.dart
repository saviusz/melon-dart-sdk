import 'dart:async';

import 'package:melon_sdk/song/data/song_cache.dart';
import 'package:melon_sdk/song/data/song_repo_events.dart';
import 'package:melon_sdk/song/song.dart';
import 'package:melon_sdk/song/data/song_source.dart';

/**
 * Source of truth for songs
 * 
 * Repozytorium jest źródłem piosenek. Zajmuje się tym, by pozyskać piosenkę z dowolnego źródła
 * oraz zapisać piosenkę w odpowiednim źródle.
 * 
 * Oznacza to, że to repozytorium decyduje, skąd pobierze piosenkę, co znajdzie się w cache
 * oraz co zostanie przesłane do innych źródeł.
 * 
 * Ważnym aspektem do zauważenia jest synchronizacja. Repozytorium jest gorliwo-leniwe.
 * Pobiera piosenkę ze zdalnych źródeł tylko wtedy, gdy jest to absolutnie konieczne.
 * Przy okazji zapamiętuję tą piosenkę na wypadek kolejnych żądań.
 * 
 * Synchronizacja służy zatem tylko do upubliczniania lokalnych zmian - usunięć, modyfikacji, dodań.
 * Sprawia to, że integracja ze zdalnymi źródłami jest mniejsza. Trudniej zarządzać uprawnieniami.
 * Jednocześnie nie jest to problem na teraz.
 * 
 * Repozytorium również powiadamia obserwatorów o zmianach w piosenkach
 */
class SongRepository {

  SongRepository({SongSource? persistentSource}) : _persistentSource = persistentSource;

  final SongCache _cache = SongCache();
  final SongSource? _persistentSource;
  final List<SongSource> _syncSources = [];

  /**
   * Returns all songs in the repository
   * 
   * This method will fetch new songs
   */
  Future<List<Song>> getSongs() async {
    
    final tasks = <Future<List<Song>>>[];

    if (_persistentSource != null) tasks.add(_persistentSource.pullSongs());
    for (final source in _syncSources) tasks.add(source.pullSongs());
    final results = await Future.wait(tasks);

    for (final result in results) _cache.putSongs(result);
    
    return _cache.getSongs();
  }

  /**
   * Adds song to repository.
   * Added song will be pushed to persistent source
   * and then to sync sources when possible
   */
  Future<void> addSong(Song song, {bool persist = false}) async {
    _cache.putSong(song);
    
    if (persist && _persistentSource != null) _persistentSource.pushSong(song);
    _eventBus.add(SongAddedToRepo(song.id));
  }

  Future<void> updateSong(Song song) async {
    throw UnimplementedError();
  }

  Future<void> deleteSong(Song song) async {
    throw UnimplementedError();
  }

  /**
   * Syncs the repository with sources
   * 
   * This method will align persistent source and cache with sync sources
   * It will not fetch new songs
   */
  Future<void> sync() async {
    throw UnimplementedError();
  }

  // Event bus

  final _eventBus = StreamController<SongEvent>.broadcast();
  Stream<SongEvent> get events => _eventBus.stream;

  Future<void> dispose() async {
    await _eventBus.close();
  }
}
