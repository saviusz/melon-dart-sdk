import 'package:equatable/equatable.dart';

class Identifier extends Equatable {

  Identifier(this.value);

  final BigInt value;

  static Identifier fromInt(int value) => Identifier(BigInt.from(value));
  static Identifier fromString(String value) => Identifier(BigInt.parse(value));
  static Identifier fromEncodedString(String value) => Identifier.fromString(value);

  String toString() => value.toString();
  String toEncodedString() => value.toRadixString(16);
  
  @override
  List<Object?> get props => [value];
}