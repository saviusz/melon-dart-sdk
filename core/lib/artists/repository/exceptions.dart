import 'package:melon_core/misc/exception.dart';

class ArtistAlreadyExistsException extends MelonException {
  ArtistAlreadyExistsException(String id) : super("Artist $id already exists");
}