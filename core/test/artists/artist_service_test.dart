import 'package:checks/checks.dart';
import 'package:melon_core/artists/artist.dart';
import 'package:melon_core/artists/service/artist_service.dart';
import 'package:melon_core/artists/service/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group("createArtist", () {
    test("creates and saves artist", () async {
      
      final service = ArtistService();
  
      final artistSnapshots = await service.createArtist(
        name: "John",
        surname: "Doe",
        pseudonym: "Test Dummy",
      ).toList();
  
  
      final returnedArtist = artistSnapshots.first;
      check(returnedArtist).isNotNull();
      check(returnedArtist.name).equals("John");
      check(returnedArtist.surname).equals("Doe");
      check(returnedArtist.pseudonym).equals("Test Dummy");
  
      check(returnedArtist.id).isNotEmpty();
  
      final savedArtist = await service.getArtistById(returnedArtist.id).first;
      check(savedArtist).equals(returnedArtist);
  
    });
  
    test("rejects creating artist without name, surname or pseudonym", () async {
      final service = ArtistService();

      final request = service.createArtist().toList();

      check(request).throws((e) => e is ArtistMissingDataException);
  
    });
    
    test("each created artist has different id", () async {
  
      final service = ArtistService();
  
      final artistSnapshots1 = await service.createArtist(
        name: "John",
        surname: "Doe",
        pseudonym: "Test Dummy",
      ).toList();
  
      final artistSnapshots2 = await service.createArtist(
        name: "John",
        surname: "Doe",
        pseudonym: "Test Dummy",
      ).toList();
  
      final returnedArtist1 = artistSnapshots1.first;
      final returnedArtist2 = artistSnapshots2.first;
  
      check(returnedArtist2.id).not((id) => id.equals(returnedArtist1.id));
    }, skip: "id generator not implemented yet");
  
  });
  group("getAllArtists", () {
    test("returns empty on no artists", () async {
      final service = ArtistService();
  
      final artists = await service.getAllArtists().first;
  
      check(artists).isEmpty;
    });
  
    test("returns all artists", () async {
      final artist1 = Artist(
        id: '---selected---',
        name: "Selected",
        surname: "Artist",
        pseudonym: "Muppet",
      );
      final artist2 = Artist(
        id: '---selected---',
        name: "Selected",
        surname: "Artist",
        pseudonym: "Muppet",
      );

      final service = ArtistService([artist1, artist2]);

      final artists = await service.getAllArtists().first;
  
      check(artists).contains(artist1);
      check(artists).contains(artist2);
    });
  }); 
  group("getArtistById", () {
    test("finds artist with given id", () async {
      final artist = Artist(
        id: '---selected---',
        name: "Selected",
        surname: "Artist",
        pseudonym: "Muppet",
      );
      final service = ArtistService([artist]);
  
      final returnedListSnapshots = await service.getArtistById("---selected---").toList();

      final returnedArtist = returnedListSnapshots.elementAtOrNull(0);
      check(returnedArtist).isNotNull();
      check(returnedArtist).equals(artist);
    });
  
    test("errors on unknown artist", () async {
      final service = ArtistService();
  
      check(service.getArtistById("unknown").first)
      .throws((e) => e is ArtistNotFoundException);
    });
  });
}
