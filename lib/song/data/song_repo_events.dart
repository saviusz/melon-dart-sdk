/* 
Eventy:
- Piosenka w repo zmieniła swój stan:
  - Została dodana
  - Została usunięta
  - Została zaktualizowana
- Piosenka została spushowana
- Piosenka została spullowana
- Pull został zakończony
- Push został zakończony
- Synchronizacja została zakończona

*/

import 'package:melon_sdk/util/id/id.dart';

abstract class SongEvent {
  final ID id;

  SongEvent(this.id);
}

class SongModifiedInRepo extends SongEvent {
  SongModifiedInRepo(ID id) : super(id);
}

class SongAddedToRepo extends SongModifiedInRepo {
  SongAddedToRepo(ID id) : super(id);
}

class SongRemovedFromRepo extends SongModifiedInRepo {
  SongRemovedFromRepo(ID id) : super(id);
}