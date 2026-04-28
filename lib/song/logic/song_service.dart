import 'dart:async';

import 'package:melon_sdk/artist/index.dart';
import 'package:melon_sdk/song/data/song_repo_events.dart';
import 'package:melon_sdk/song/data/song_repository.dart';
import 'package:melon_sdk/util/id/id.dart';
import 'package:melon_sdk/util/id/id_generator.dart';

import '../expections.dart';
import '../song.dart';

class SongService {
  SongService(
      {required ArtistService artists,
      required IdGenerator idGenerator,
      required SongRepository repo})
      : _artists = artists,
        _repo = repo,
        _idGenerator = idGenerator;

  final IdGenerator _idGenerator;
  final ArtistService _artists;
  final SongRepository _repo;

  Future<ID> createSong({required String title}) async {
    if (title.isEmpty) {
      throw EmptySongTitleException();
    }

    final id = _idGenerator.generate();
    final song = Song(id: id, title: title);

    _repo.addSong(song);
    return id;
  }

  Stream<List<Song>> viewSongs() async* {
    yield await getSongs();
    await for (final event in _repo.events) {
      if (event case SongModifiedInRepo _) {
        yield await getSongs();
      }
    }
  }

  Future<List<Song>> getSongs() async {
    return _repo.getSongs();
  }

  Future<void> assignAuthor(ID songId, ID authorId) async {
    throw UnimplementedError();
  }

  Future<void> assignPerformer(ID songId, ID performerId) async {
    throw UnimplementedError();
  }
}
