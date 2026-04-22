import 'package:equatable/equatable.dart';
import 'package:melon_sdk/util/id/id.dart';

class Artist extends Equatable {
  final ID id;
  final String? name;
  final String? surname;
  final String? pseudonym;

  Artist({required this.id, this.name, this.surname, this.pseudonym});
  
  List<Object?> get props => [id, name, surname, pseudonym];
}