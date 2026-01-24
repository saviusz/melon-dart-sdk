import 'package:equatable/equatable.dart';

class ArtistRecord extends Equatable {
  final String id;
  final String? name;
  final String? surname;
  final String? pseudonym;

  ArtistRecord({required this.id, this.name, this.surname, this.pseudonym});

  @override
  List<Object?> get props => ["id", "name", "surname", "pseudonym"];

  @override
  String toString() {
    return 'ArtistRecord{id: $id, name: $name, surname: $surname, pseudonym: $pseudonym}';
  }
}
