import 'package:checks/checks.dart';
import 'package:melon_core/artists/repository/dummy_artist_repository.dart';
import 'package:melon_core/artists/service/artist_service.dart';
import 'package:melon_core/artists/service/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group("createArtist", () {
  
    test("rejects creating artist without name, surname or pseudonym", () async {
      final repo = DummyArtistRepository();
      final service = ArtistService(repo);

      final request = service.createArtist().toList();

      check(request).throws((e) => e is ArtistMissingDataException);
  
    });
    
    test("each created artist has different id", () async {
  
      final repo = DummyArtistRepository();
      final service = ArtistService(repo);
  
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
}
