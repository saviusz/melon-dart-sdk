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

  test("multiple additions of same song fails", () async {
    final melon = MelonCore();

    melon.createSong(title: "Test Title");
    check(() => melon.createSong(title: "Test Title")).throws();
  });
}
