import 'package:checks/checks.dart';
import 'package:melon_core/artists/artist.dart';
import 'package:melon_core/artists/artist_repository.dart';
import 'package:melon_core/artists/artist_service.dart';
import 'package:melon_core/misc/exception.dart';
import 'package:melon_core/misc/snapshot.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([MockSpec<ArtistRepository>()])
import 'artist_service_test.mocks.dart';

/* Ten serwis:
- generuje id nowych artystów
- pobiera artystów z repozytorium
- aktualizuje artystów w repozytorium
- pokazuje stany ładowania
- waliduje dane
*/

void main() {
  test("get all artists is empty", () async {
    final repo = MockArtistRepository();
    final melon = ArtistService(repo: repo);

    when(repo.list()).thenAnswer((_) {
      return Stream.fromIterable([
        LoadingSnapshot<List<ArtistRecord>>(source: SourceType.static),
        DataSnapshot<List<ArtistRecord>>(data: [], source: SourceType.static),
      ]);
    });
    final snapshots = await melon.getAllArtists().toList();

    check(snapshots).isNotEmpty();
    check(snapshots[0]).isA<LoadingSnapshot>();
    check(snapshots[1]).isA<DataSnapshot>();
    final snapshot = snapshots[1] as DataSnapshot<List<ArtistRecord>>;
    check(snapshot.data).isEmpty();
  });

  test("create artist without data fails", () async {
    final repo = MockArtistRepository();
    final melon = ArtistService(repo: repo);

    final snapshots = await melon.createArtist().toList();
    check(snapshots).isNotEmpty();
    var snapshot = snapshots.first;
    check(snapshot).isA<ErrorSnapshot>();

    snapshot = snapshot as ErrorSnapshot<ArtistRecord>;
    check(snapshot.error).isA<MelonException>();
  });

  test("get artist by id fails", () async {
    final repo = MockArtistRepository();
    final melon = ArtistService(repo: repo);

    final request = await melon.getArtistById("unknown").toList();

    check(request).isNotEmpty();
    check(request.first).isA<ErrorSnapshot>();

    final snapshot = request.first as ErrorSnapshot<ArtistRecord>;
    check(snapshot.error).isA<MelonException>();
  });

  test("created artists have different ids", () async {
    final repo = MockArtistRepository();
    final melon = ArtistService(repo: repo);

    when(repo.add(any)).thenAnswer((_) => Stream.fromIterable([
          DataSnapshot(
              source: SourceType.static,
              data: ArtistRecord(
                id: "---test-id---",
                name: "",
                surname: "",
                pseudonym: "",
              ))
        ]));

    final artist1 = await melon
        .createArtist(
          name: "Test",
          surname: "Dummy",
          pseudonym: "",
        )
        .first;
    final artist2 = await melon
        .createArtist(
          name: "Test",
          surname: "Dummy",
          pseudonym: "",
        )
        .first;

    check(artist1).isA<DataSnapshot>();
    check(artist2).isA<DataSnapshot>();
    final snapshot1 = artist1 as DataSnapshot<ArtistRecord>;
    final snapshot2 = artist2 as DataSnapshot<ArtistRecord>;
    check(snapshot1.data.id).equals("---test-id---");
    check(snapshot2.data.id).equals("---test-id---");

    var captured = verify(repo.add(captureAny));
    check(captured.callCount).equals(2);
    final captured1 = captured.captured[0] as ArtistRecord;
    final captured2 = captured.captured[1] as ArtistRecord;
    check(captured1.id).not((c) => c.equals(captured2.id));
  }, skip: "random id generation is not implemented yet");
}
