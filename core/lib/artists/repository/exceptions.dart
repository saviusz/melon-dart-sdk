import 'package:melon_core/misc/exception.dart';
import 'package:melon_core/misc/identifier.dart';

class ArtistAlreadyExistsException extends MelonException {
  ArtistAlreadyExistsException(Identifier id) : super("Artist $id already exists");
}