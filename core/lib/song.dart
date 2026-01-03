import 'package:equatable/equatable.dart';

class Song extends Equatable {
  Song({required this.id, required this.title});

  final String id;
  final String title;

  @override
  List<Object?> get props => [id, title];
}
