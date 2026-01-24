import 'package:melon_core/misc/exception.dart';

enum SourceType {static, cache, memory, network }

sealed class Snapshot<T> {}

class DataSnapshot<T> extends Snapshot<T> {
  final T data;
  final SourceType source;

  DataSnapshot({required this.source, required this.data});
}

class ErrorSnapshot<T> extends Snapshot<T> {
  final MelonException error;

  ErrorSnapshot({required this.error});
}

class LoadingSnapshot<T> extends Snapshot<T> {
  /// Source that is loading
  final SourceType source;

  LoadingSnapshot({required this.source});
}
