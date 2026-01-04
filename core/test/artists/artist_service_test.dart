import 'package:checks/checks.dart';
import 'package:melon_core/artists/artist_service.dart';
import 'package:test/test.dart';

void main() {

  test("get all artists is empty", () async {
    final melon = ArtistService();
    check(melon.getAllArtists()).isEmpty;
  });

  test("create artist without data fails", () async {
    final melon = ArtistService();
    check(() => melon.createArtist()).throws();
  });

  test("get artist by id fails", () async {
    final melon = ArtistService();
    check(() => melon.getArtistById("unknown")).throws();
  });

  test("created artists have different ids", () async {
    final melon = ArtistService();

    final artist1 = melon.createArtist();
    final artist2 = melon.createArtist();

    check(artist1.id).not((e) => e.equals(artist2.id));
  }, skip: "random id generation is not implemented yet");
}