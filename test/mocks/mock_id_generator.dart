import 'package:melon_sdk/util/id/id.dart';
import 'package:melon_sdk/util/id/id_generator.dart';

class MockIdGenerator implements IdGenerator {
  
  var counter = 1;
  
  @override
  ID generate() {
    return ID(counter++);
  }
  
}