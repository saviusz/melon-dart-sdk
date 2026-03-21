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

  group("Assign artist", () {
    late String songId;
    late String authorId;

    setUp(() async {
      authorId = await artistsService.createArtist(pseudonym: "Dummy");
      songId = await songService.createSong(title: "Dummy");
    });

    test("Assign author", () async {
      await songService.assignAuthor(songId, authorId);

      final song = await songService.getSong(songId);
      expect(song, isA<Song>().having((song) => song.authorIds, "authorIds", [authorId]));
    });

    test("Assign performer", () async {
      await songService.assignPerformer(songId, authorId);

      final song = await songService.getSong(songId);
      expect(song, isA<Song>().having((song) => song.performerIds, "performerIds", [authorId]));
    });
  });
}
