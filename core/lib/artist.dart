import 'package:equatable/equatable.dart';

class Artist extends Equatable {
  final String id;
  final String? name;
  final String? surname;
  final String? pseudonym;

  Artist({required this.id, this.name, this.surname, this.pseudonym});

  @override
  List<Object?> get props => ["id", "name", "surname", "pseudonym"];
}
