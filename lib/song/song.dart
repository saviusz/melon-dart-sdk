import 'package:equatable/equatable.dart';
import 'package:melon_sdk/util/id/id.dart';

class Song extends Equatable {
  Song({required this.id, required this.title});
  
  @override
  List<Object?> get props => [id, title, authorIds, performerIds];

  final ID id;
  final String title;
  final List<ID> authorIds = [];
  final List<ID> performerIds = [];

  Song withAuthor(ID authorId) {
    authorIds.add(authorId);
    return this;
  }

  Song withPerformer(ID performerId) {
    performerIds.add(performerId);
    return this;
  }
  
}