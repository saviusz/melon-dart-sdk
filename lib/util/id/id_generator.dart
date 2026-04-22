import 'id.dart';

class IdGenerator {
  static final epoch = DateTime.parse("2026-01-01");

  int _counter = 0;
  var _lastTimeStamp = IdGenerator.epoch;

  ID generate() {
    final now = DateTime.timestamp();

    if (now.difference(_lastTimeStamp).inSeconds > 1 || _counter > 999) {
      _lastTimeStamp = now;
      _counter = 0;
    } else {
      _counter++;
    }

    final timestamp = now.difference(IdGenerator.epoch).inSeconds;
    final number = timestamp * 1000 + _counter;

    return ID(number);
  }
}
