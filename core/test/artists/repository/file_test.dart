@TestOn("vm")
import 'dart:io';

import 'package:checks/checks.dart';
import 'package:melon_core/artists/artist.dart';
import 'package:melon_core/artists/repository/file_repo.dart';
import 'package:melon_core/artists/service/exceptions.dart';
import 'package:test/test.dart';

void main() {
  late Directory testDir;
  setUp(() async {
    final dir = Directory("tmp/artists");
    await dir.create(recursive: true);
    testDir = await dir.createTemp();
  });

  tearDown(() async {
      await testDir.delete(recursive: true);
  });

  group("read artist", () {
    test("throw if artist does not exist", () async {
      final repo = FileArtistRepository(testDir.path);

      final request = repo.get("unknown-id").toList();

      check(request).throws((e) {
        e.isA<ArtistNotFoundException>();
      });
    });
    test("return artist if it exists", () async {
      final artist = Artist(
        id: "artist-id",
        name: "John",
        surname: "Doe",
        pseudonym: "Test Dummy",
      );

      final file = File("${testDir.path}/${artist.id}.json");
      file.create();
      await file.writeAsString("""
      {
        "id": "${artist.id}",
        "name": "${artist.name}",
        "surname": "${artist.surname}",
        "pseudonym": "${artist.pseudonym}"
      }
      """);

      final repo = FileArtistRepository(testDir.path);

      final snapshots = await repo.get(artist.id).toList();
      check(snapshots.length).equals(1);

      final returnedArtist = snapshots.elementAtOrNull(0);
      check(returnedArtist).equals(artist);
    });
  });

  group("list artists", () {
    test("return empty list", () async {
      final repo = FileArtistRepository(testDir.path);

      final snapshots = await repo.list().toList();
      check(snapshots.length).equals(1);

      final returnedList = snapshots.elementAtOrNull(0);
      check(returnedList).isNotNull();
      check(returnedList!).isEmpty();
    });
    test("return list with artists", () async {
      final artist = Artist(
        id: "artist-id",
        name: "John",
        surname: "Doe",
        pseudonym: "Test Dummy",
      );
      final file = File("${testDir.path}/${artist.id}.json");
      await file.create();
      await file.writeAsString("""
      {
        "id": "${artist.id}",
        "name": "${artist.name}",
        "surname": "${artist.surname}",
        "pseudonym": "${artist.pseudonym}"
      }
      """);

      final repo = FileArtistRepository(testDir.path);

      final snapshots = await repo.list().toList();
      check(snapshots.length).equals(1);

      final returnedList = snapshots.elementAtOrNull(0);
      check(returnedList).isNotNull();
      check(returnedList!).deepEquals([artist]);
    });
  });

  group("check if artists exist", () {
    test("return true if artist exists", () async {
      final artist = Artist(
        id: "artist-id",
        name: "John",
        surname: "Doe",
        pseudonym: "Test Dummy",
      );
      final file = File("${testDir.path}/${artist.id}.json");
      await file.create();
      await file.writeAsString("""
      {
        "id": "${artist.id}",
        "name": "${artist.name}",
        "surname": "${artist.surname}",
        "pseudonym": "${artist.pseudonym}"
      }
      """);

      final repo = FileArtistRepository(testDir.path);

      final snapshots = await repo.has(artist.id).toList();
      check(snapshots.length).equals(1);

      final returnedState = snapshots.elementAtOrNull(0);
      check(returnedState).equals(true);
    });
    test("return false if artist does not exist", () async {
      final repo = FileArtistRepository(testDir.path);

      final snapshots = await repo.has("unknown-id").toList();
      check(snapshots.length).equals(1);

      final returnedState = snapshots.elementAtOrNull(0);
      check(returnedState).equals(false);
    });
  });

  group("create artist", () {
    test("save artist", () async {
      final repo = FileArtistRepository(testDir.path);

      final artist = Artist(
        id: "artist-id",
        name: "John",
        surname: "Doe",
        pseudonym: "Test Dummy",
      );

      final snapshots = await repo.create(artist).toList();
      check(snapshots.length).equals(1);

      final returnedArtist = snapshots.elementAtOrNull(0);
      check(returnedArtist).equals(artist);

      check(File("${testDir.path}/${artist.id}.json").existsSync()).equals(true);
    });
  });
}
