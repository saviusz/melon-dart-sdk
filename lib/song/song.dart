import 'package:equatable/equatable.dart';

class Song extends Equatable {
  Song({required this.id, required this.title});
  
  @override
  List<Object?> get props => [id, title, authorIds, performerIds];

  final String id;
  final String title;
  final List<String> authorIds = [];
  final List<String> performerIds = [];

  Song withAuthor(String authorId) {
    authorIds.add(authorId);
    return this;
  }

  Song withPerformer(String performerId) {
    performerIds.add(performerId);
    return this;
  }
  
}