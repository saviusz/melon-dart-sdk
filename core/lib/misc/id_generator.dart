import 'package:melon_core/misc/identifier.dart';

class IdGenerator {
  int _counter = 0;
  DateTime _lastTime = DateTime.now();

  IdGenerator({DateTime? epoch, required int instanceId})
      : assert(instanceId > 0),
        assert(instanceId < 1024),
        this.epoch = epoch ?? DateTime(2026, 1, 1, 0, 0),
        this.instanceId = instanceId;

  final DateTime epoch;
  final int instanceId;

  Identifier generate() {
    BigInt value = BigInt.from(0);

    final now = DateTime.now();
    final delta = now.difference(_lastTime).inMilliseconds;
    if (delta > 1000 || _counter > 0x3ff) {
      _counter = 0;
      if (_lastTime == now) {
        _lastTime = _lastTime.add(Duration(seconds: 1));
      }
      _lastTime = now;
    } else {
      _counter++;
    }

    final timestamp = epoch.difference(_lastTime).inSeconds;
    value += BigInt.from(timestamp & 0x3fff_ffff) << 20;
    value += BigInt.from(this.instanceId & 0x3ff) << 10;
    value += BigInt.from(_counter & 0x3ff);

    return Identifier(value);
  }
}
