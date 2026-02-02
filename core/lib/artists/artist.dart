import 'package:equatable/equatable.dart';
import 'package:melon_core/misc/identifier.dart';

class Artist extends Equatable {
  final Identifier id;
  final String? name;
  final String? surname;
  final String? pseudonym;

  Artist({required this.id, this.name, this.surname, this.pseudonym});

  @override
  List<Object?> get props => ["id", "name", "surname", "pseudonym"];

  factory Artist.fromJson(jsonDecode) {
    return Artist(
      id: Identifier.fromEncodedString(jsonDecode["id"]),
      name: jsonDecode["name"],
      surname: jsonDecode["surname"],
      pseudonym: jsonDecode["pseudonym"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id.toEncodedString(),
        "name": name,
        "surname": surname,
        "pseudonym": pseudonym,
      };

}
