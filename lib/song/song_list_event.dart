import 'package:melon_sdk/artist/index.dart';

import 'song.dart';

sealed class SongListEvent {}
sealed class SongEvent extends SongListEvent {}
class SongCreated extends SongEvent {
  
  SongCreated({required this.song});
  final Song song;

  @override
  String toString() => "SongCreated($song)";

}
class ArtistAssigned extends SongEvent {
  
  ArtistAssigned({required this.artist, required this.song});
  final Artist artist;
  final Song song;

}
class PerformerAssigned extends ArtistAssigned {
  PerformerAssigned({required super.artist, required super.song});

  @override
  toString() => "PerformerAssigned($artist, $song)";
}
class AuthorAssigned extends ArtistAssigned {
  AuthorAssigned({required super.artist, required super.song});

  @override
  toString() => "AuthorAssigned($artist, $song)";
}