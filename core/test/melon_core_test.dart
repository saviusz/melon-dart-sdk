import 'package:checks/checks.dart';
import 'package:melon_core/melon_core.dart';
import 'package:test/test.dart';

void main() {
  test('create simple song', () async {
    final melon = MelonCore();

    final song = melon.createSong(title: "Test Title");

    check(melon.getSongById(song.id)).equals(song);
    check(melon.getAllSongs()).contains(song);
  });

  test('get all songs is empty', () async {
    final melon = MelonCore();
    check(melon.getAllSongs()).isEmpty;
  });

  test("create song without title fails", () async {
    final melon = MelonCore();
    check(() => melon.createSong(title: "")).throws();
  });

  test("unknown song fails", () async {
    final melon = MelonCore();
    check(() => melon.getSongById("unknown")).throws();
  });

  test("created songs have different ids", () async {
    final melon = MelonCore();

    final song1 = melon.createSong(title: "Test Title");
    final song2 = melon.createSong(title: "Test Title");

    check(song1.id).not((e) => e.equals(song2.id));
  }, skip: "random id generation is not implemented yet");

  test("get all artists is empty", () async {
    final melon = MelonCore();
    check(melon.getAllArtists()).isEmpty;
  });

  test("create artist without data fails", () async {
    final melon = MelonCore();
    check(() => melon.createArtist()).throws();
  });

  test("get artist by id fails", () async {
    final melon = MelonCore();
    check(() => melon.getArtistById("unknown")).throws();
  });

  test("created artists have different ids", () async {
    final melon = MelonCore();

    final artist1 = melon.createArtist();
    final artist2 = melon.createArtist();

    check(artist1.id).not((e) => e.equals(artist2.id));
  }, skip: "random id generation is not implemented yet");
  
}
