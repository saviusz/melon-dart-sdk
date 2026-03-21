import 'package:melon_sdk/artist/artist_exceptions.dart';
import 'package:melon_sdk/artist/index.dart';
import 'package:test/test.dart';

void main() {
  late ArtistService artistsService;

  setUp(() {
    artistsService = ArtistService();
  });

  test("Create artist", () async {
    expectLater(
      artistsService.viewArtists(),
      emitsInOrder(
        [
          [
            isA<Artist>()
                .having((a) => a.name, "name", "John")
                .having((a) => a.surname, "surname", "Doe")
                .having((a) => a.pseudonym, "pseudonym", "John Doe")
          ]
        ],
      ),
    );

    final artistId = await artistsService.createArtist(
      name: "John",
      surname: "Doe",
      pseudonym: "John Doe",
    );

    expect(artistId, isNotEmpty, reason: "Artist id should not be empty");

    final artists = await artistsService.getArtists();
    expect(
      artists,
      contains(
        new Artist(
          id: artistId,
          name: "John",
          surname: "Doe",
          pseudonym: "John Doe",
        ),
      ),
    );
  });

  test("Drop without name", () async {
    expect(
      () => artistsService.createArtist(),
      throwsA(isA<EmptyArtistNameException>()),
    );
  });
}
