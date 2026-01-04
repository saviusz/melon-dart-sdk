import 'package:checks/checks.dart';
import 'package:melon_core/songs/song_repo_dummy.dart';
import 'package:melon_core/songs/song_service.dart';
import 'package:test/test.dart';

SongService createEnv() {
  final repo = SongRepoDummy();
  return SongService(repo: repo);
}

void main() {
  test('create simple song', () async {
    final melon = createEnv();

    final song = await melon.createSong(title: "Test Title");

    check(await melon.getSongById(song.id)).equals(song);
    check(await melon.getAllSongs()).contains(song);
  });

  test('get all songs is empty', () async {
    final melon = createEnv();
    check(await melon.getAllSongs()).isEmpty;
  });

  test("create song without title fails", () async {
    final melon = createEnv();
    check(melon.createSong(title: "")).throws();
  });

  test("unknown song fails", () async {
    final melon = createEnv();
    check(melon.getSongById("unknown")).throws();
  });

  test("created songs have different ids", () async {
    final melon = createEnv();

    final song1 = await melon.createSong(title: "Test Title");
    final song2 = await melon.createSong(title: "Test Title");

    check(song1.id).not((e) => e.equals(song2.id));
  }, skip: "random id generation is not implemented yet");
}
