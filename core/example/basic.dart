import 'package:melon_core/artists/artist.dart';
import 'package:melon_core/artists/repository/file_repo.dart';
import 'package:melon_core/artists/service/artist_service.dart';

Future<void> main(List<String> args) async {
  // Initialize components
  final artistRepo = FileArtistRepository("./run/artists");
  final artistService = ArtistService(artistRepo);
  
  // Run actions
  final artists = await artistService.getAllArtists().first;
  printArtists(artists);

  final artist = await artistService.createArtist(
    name: "John",
    surname: "Doe",
    pseudonym: "Test Dummy",
  ).first;
  print("Created artist: ${formatArtist(artist)}");

  final foundArtist = await artistService.getArtistById(artist.id).first;
  print("Found artist: ${formatArtist(foundArtist)}");

  final foundArtists = await artistService.getAllArtists().first;
  printArtists(foundArtists);
}

void printArtists(List<Artist> artists) {
  print("Found ${artists.length} artists: ");
  for (final artist in artists) {
    print("- ${formatArtist(artist)}");
  }
}

String formatArtist(Artist artist) {
  final array = [];
  array.add(artist.name);
  array.add(artist.surname);
  array.add("\"${artist.pseudonym}\"");
  array.add("(${artist.id})");
  return array.join(" ");
}