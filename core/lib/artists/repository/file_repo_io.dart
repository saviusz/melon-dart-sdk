import 'dart:convert';
import 'dart:io';

import 'package:melon_core/artists/artist.dart';
import 'package:melon_core/artists/repository/artist_repository.dart';
import 'package:melon_core/artists/repository/exceptions.dart';
import 'package:melon_core/artists/service/exceptions.dart';

class FileArtistRepository implements ArtistRepository {
  final String basePath;

  FileArtistRepository(this.basePath);

  @override
  Stream<Artist> create(Artist artist) async* {
    final file = File("$basePath/${artist.id}.json");
    try {
      await file.create(exclusive: true, recursive: true);
    } catch (e) {
      if (e is PathExistsException) {
        throw ArtistAlreadyExistsException(artist.id);
      }
    }

    await file.writeAsString(jsonEncode(artist));
    yield artist;
  }

  @override
  Stream<Artist> get(String id) async* {
    final file = File("$basePath/$id.json");
    if (!await file.exists()) {
      throw ArtistNotFoundException(id);
    }

    final text = await file.readAsString();
    yield Artist.fromJson(jsonDecode(text));
  }

  @override
  Stream<bool> has(String id) async* {
    final file = File("$basePath/$id.json");
    yield await file.exists();
  }

  @override
  Stream<List<Artist>> list() async* {
    final directory = Directory(basePath);
    yield await directory
        .list()
        .where((entity) => entity.path.endsWith(".json"))
        .map((entity) => entity.path)
        .map((path) {
            final file = File(path);
            final text = file.readAsStringSync();
            return Artist.fromJson(jsonDecode(text));
        })
        .toList();
  }
}
