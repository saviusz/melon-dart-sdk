import 'package:checks/checks.dart';
import 'package:melon_core/artists/artist.dart';
import 'package:melon_core/artists/repository/dummy_artist_repository.dart';
import 'package:melon_core/artists/service/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group("read artist", () {
    test("throw if artist does not exist", () async {
      final list = <Artist>[];
      final repo = DummyArtistRepository(list);
      
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
      
      final list = <Artist>[artist];
      final repo = DummyArtistRepository(list);
      
      final snapshots = await repo.get(artist.id).toList();
      check(snapshots.length).equals(1);
      
      final returnedArtist = snapshots.elementAtOrNull(0);
      check(returnedArtist).equals(artist);
    });
  });

  group("list artists", () {
    test("return empty list", () async {
      final list = <Artist>[];
      final repo = DummyArtistRepository(list);
      
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
      
      final list = <Artist>[artist];
      final repo = DummyArtistRepository(list);
      
      final snapshots = await repo.list().toList();
      check(snapshots.length).equals(1);
      
      final returnedList = snapshots.elementAtOrNull(0);
      check(returnedList).isNotNull();
      check(returnedList!).equals(list);
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
      
      final list = <Artist>[artist];
      final repo = DummyArtistRepository(list);
      
      final snapshots = await repo.has(artist.id).toList();
      check(snapshots.length).equals(1);
      
      final returnedState = snapshots.elementAtOrNull(0);
      check(returnedState).equals(true);
    });
    test("return false if artist does not exist", () async {
      final list = <Artist>[];
      final repo = DummyArtistRepository(list);
      
      final snapshots = await repo.has("unknown-id").toList();
      check(snapshots.length).equals(1);
      
      final returnedState = snapshots.elementAtOrNull(0);
      check(returnedState).equals(false);
    });
  });

  group("create artist", () {
    test("save artist", () async {
      
      final list = <Artist>[];
      final repo = DummyArtistRepository(list);
      
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

      check(list.length).equals(1);
      check(list.first).equals(artist);
    });
  });
}
