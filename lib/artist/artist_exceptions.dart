import 'package:melon_sdk/util/id/id.dart';

class EmptyArtistNameException implements Exception {}

class ArtistNotFoundException implements Exception {
  
  final ID artistId;
  
  const ArtistNotFoundException({required this.artistId});

  @override
  String toString() => "Artist with id \"$artistId\" not found";
}
