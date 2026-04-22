import 'artist.dart';

sealed class ArtistListEvent {}

class ArtistCreated extends ArtistListEvent {
  ArtistCreated(this.artist);
  final Artist artist;

  @override
  String toString() => "ArtistCreated($artist)";
}