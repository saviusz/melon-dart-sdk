import 'package:melon_core/artists/artist.dart';
import 'package:melon_core/artists/artist_repository.dart';
import 'package:melon_core/artists/artist_service.dart';
import 'package:melon_core/artists/artist_source_dummy.dart';
import 'package:melon_core/misc/snapshot.dart';

Future<void> main() async {
  final artistSource = ArtistSourceDummy([
    ArtistRecord(id: "1", name: "Kasia", surname: "Sochacka"),
    ArtistRecord(id: "2", pseudonym: "Kwiat Jabłoni"),
    ArtistRecord(
        id: "3",
        name: "Filip",
        surname: "Szcześniak",
        pseudonym: "Taco Hemingway"),
  ]);

  final artistRepo = ArtistRepository(memorySources: [artistSource]);

  final artistService = ArtistService(repo: artistRepo);

  await for (final allArtists in artistService.getAllArtists()) {
    switch (allArtists) {
      case LoadingSnapshot<List<ArtistRecord>>(:final source):
        print("Ładowanie artystów z $source");
        break;
      case DataSnapshot<List<ArtistRecord>>(:final data, :final source):
        print("Wszyscy artysci (z $source):");
        data.forEach((artist) => print(artist));
        break;
      case ErrorSnapshot<List<ArtistRecord>>(:final error):
        print("Błąd ładowania artystów: $error");
        break;
    }
  }

  print("");

  await for (final addedArtist
      in artistService.createArtist(name: "Nowy", surname: "Artysta")) {
    switch (addedArtist) {
      case LoadingSnapshot<ArtistRecord>(:final source):
        print("Dodawanie artysty z $source z danymi $addedArtist");
        break;
      case DataSnapshot<ArtistRecord>(:final data, :final source):
        print("Dodano artystę do $source: $data");
        break;
      case ErrorSnapshot<ArtistRecord>(:final error):
        print("Błąd przy dodawaniu artysty: $error");
        break;
    }
  }

  print("");

  await for (final allArtists in artistService.getAllArtists()) {
    switch (allArtists) {
      case LoadingSnapshot<List<ArtistRecord>>(:final source):
        print("Ładowanie artystów z $source");
        break;
      case DataSnapshot<List<ArtistRecord>>(:final data, :final source):
        print("Wszyscy artysci (z $source):");
        data.forEach((artist) => print(artist));
        break;
      case ErrorSnapshot<List<ArtistRecord>>():
        print("Wszyscy artysci: Error");
        break;
    }
  }
}
