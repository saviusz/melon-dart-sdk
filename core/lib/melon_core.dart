import 'package:melon_core/artist.dart';
import 'package:melon_core/song.dart';

class MelonCore {
  final List<Song> _songs = [];
  final List<Artist> _artists = [];

  Song createSong({required String title}) {
    if (title.isEmpty) {
      throw Exception('Title cannot be empty');
    }

    if (_songs.any((song) => song.title == title)) {
      throw Exception('Song already exists');
    }

    final song = Song(id: '---id---', title: title);
    _songs.add(song);
    return song;
  }

  Song getSongById(String id) {
    try {
      final song = _songs.firstWhere((song) => song.id == id);
      return song;
    } catch (e) {
      throw Exception('Song not found');
    }
  }

  List<Song> getAllSongs() {
    return _songs.toList();
  }

  List<Artist> getAllArtists() {
    return _artists.toList();
  }

  Artist createArtist({
    String? name,
    String? surname,
    String? pseudonym,
  }) {
    final artist = Artist(
      id: '---id---',
      name: name,
      surname: surname,
      pseudonym: pseudonym,
    );
    _artists.add(artist);
    return artist;
  }

  Artist getArtistById(String id) {
    try {
      final artist = _artists.firstWhere((artist) => artist.id == id);
      return artist;
    } catch (e) {
      throw Exception('Artist not found');
    }
  }
}
