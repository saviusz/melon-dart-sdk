import 'package:melon_sdk/index.dart';
import 'package:melon_sdk/song/expections.dart';
import 'package:test/test.dart';

void main() {
  late ArtistService artistsService;
  late SongService songService;

  setUp(() {
    artistsService = ArtistService();
    songService = SongService(artists: artistsService);
  });

  tearDown(() async {
    await songService.dispose();
  });

  test("Create song", () async {
    final title = "Title";

    expectLater(
        songService.viewSongs(),
        emitsInOrder([
          [isA<Song>().having((song) => song.title, "title", title)]
        ]));

    final songId = await songService.createSong(title: title);
    expect(songId, isNotEmpty, reason: "Song id should not be empty");

    final songs = await songService.getSongs();
    expect(songs, contains(new Song(id: songId, title: title)));
  });

  test("Drop without title", () async {
    final request = songService.createSong(title: "");

    expect(request, throwsA(isA<EmptySongTitleException>()));

    final songs = await songService.getSongs();
    expect(songs, isEmpty);
  });
}
