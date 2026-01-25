import 'package:melon_core/misc/exception.dart';

class ArtistNotFoundException extends MelonException {
  String id;

  ArtistNotFoundException(this.id) : super('Could not find artist with id: $id');
}

class ArtistMissingDataException extends MelonException {
  ArtistMissingDataException() : super('Artist require name, surname or pseudonym');
}