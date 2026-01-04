import 'package:checks/checks.dart';
import 'package:melon_core/songs/song_service.dart';
import 'package:test/test.dart';

void main() {
  test('create simple song', () async {
    final melon = SongService();

    final song = melon.createSong(title: "Test Title");

    check(melon.getSongById(song.id)).equals(song);
    check(melon.getAllSongs()).contains(song);
  });

  test('get all songs is empty', () async {
    final melon = SongService();
    check(melon.getAllSongs()).isEmpty;
  });

  test("create song without title fails", () async {
    final melon = SongService();
    check(() => melon.createSong(title: "")).throws();
  });

  test("unknown song fails", () async {
    final melon = SongService();
    check(() => melon.getSongById("unknown")).throws();
  });

  test("created songs have different ids", () async {
    final melon = SongService();

    final song1 = melon.createSong(title: "Test Title");
    final song2 = melon.createSong(title: "Test Title");

    check(song1.id).not((e) => e.equals(song2.id));
  }, skip: "random id generation is not implemented yet");
}