import 'song.dart';

sealed class SongListEvent {}
sealed class SongEvent extends SongListEvent {}
class SongCreated extends SongEvent {
  
  SongCreated({required this.song});
  final Song song;

}