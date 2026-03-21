import 'package:melon_sdk/index.dart';
import 'package:melon_sdk/song/expections.dart';
import 'package:spec/spec.dart';


void main() {
  test("Create song", () async {

    final artistService = ArtistService();
    final songService = SongService(artists: artistService);

    final songId = await songService.createSong(title: "Title");
    expect(songId).toBeTruthy();

    final songs = await songService.getSongs();
    expect(songs).contains(new Song(id: songId, title: "Title"));

  });

  test("Drop without title", () async {

    final artistService = ArtistService();
    final songService = SongService(artists: artistService);

    final request = songService.createSong(title: "");
    expect(request).throws.isA<EmptySongTitleException>();

    final songs = await songService.getSongs();
    expect(songs).toHaveLength(0);

  });
}
