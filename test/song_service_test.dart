import 'package:melon_sdk/song/empty_song_title_exception.dart';
import 'package:spec/spec.dart';

import 'package:melon_sdk/song/song.dart';
import 'package:melon_sdk/song/song_service.dart';

void main() {
  test("Create song", () async {

    final songService = SongService();

    final songId = await songService.createSong(title: "Title");
    expect(songId).toBeTruthy();

    final songs = await songService.getSongs();
    expect(songs).contains(new Song(id: songId, title: "Title"));

  });

  test("Drop without title", () async {

    final songService = SongService();

    final request = songService.createSong(title: "");
    expect(request).throws.isA<EmptySongTitleException>();

    final songs = await songService.getSongs();
    expect(songs).toHaveLength(0);

  });
}
