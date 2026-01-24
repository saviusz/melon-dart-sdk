import 'package:melon_core/artists/artist.dart';
import 'package:melon_core/misc/exception.dart';
import 'package:melon_core/misc/snapshot.dart';

import 'artist_source.dart';

class ArtistRepository {
  ArtistRepository(
      {this.cacheSource = const [],
      this.memorySources = const [],
      this.networkSources = const []});

  final List<ArtistSource> cacheSource;
  final List<ArtistSource> memorySources;
  final List<ArtistSource> networkSources;

  Stream<Snapshot<ArtistRecord>> get(String id) async* {
    ArtistRecord? artist = null;

    yield LoadingSnapshot(source: SourceType.cache);

    artist = await Future.any(cacheSource.map((source) => source.get(id)));
    yield artist != null
        ? DataSnapshot(source: SourceType.cache, data: artist)
        : LoadingSnapshot(source: SourceType.memory);

    artist = await Future.any(memorySources.map((source) => source.get(id)));
    yield artist != null
        ? DataSnapshot(source: SourceType.memory, data: artist)
        : LoadingSnapshot(source: SourceType.network);

    artist = await Future.any(networkSources.map((source) => source.get(id)));
    yield artist != null
        ? DataSnapshot(source: SourceType.network, data: artist)
        : ErrorSnapshot(
            error: MelonException("Artist not found"),
          );
  }

  Stream<Snapshot<List<ArtistRecord>>> list() async* {
    List<ArtistRecord>? artists;

    yield LoadingSnapshot(source: SourceType.network);

    if (networkSources.isNotEmpty) {
      artists = await Future.any(networkSources.map((source) => source.list()));
    }
    yield artists != null
        ? DataSnapshot(source: SourceType.network, data: artists)
        : LoadingSnapshot(source: SourceType.memory);
    
    if (memorySources.isNotEmpty) { 
      artists = await Future.any(memorySources.map((source) => source.list()));
    }
    yield artists != null
        ? DataSnapshot(source: SourceType.memory, data: artists)
        : DataSnapshot(source: SourceType.static, data: []);
  }

  Stream<Snapshot<ArtistRecord>> add(ArtistRecord artist) async* {
    yield LoadingSnapshot(source: SourceType.network);

    final added = await Future.any(memorySources.map((source) => source.add(artist)));
    yield DataSnapshot(source: SourceType.memory, data: added);
  }

  Stream<Snapshot<ArtistRecord>> update(ArtistRecord artist) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
