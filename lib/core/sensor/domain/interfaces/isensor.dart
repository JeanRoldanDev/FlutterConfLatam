import 'package:flutterconflatam/core/sensor/domain/models/cardio_result.dart';
import 'package:flutterconflatam/core/sensor/domain/models/event_data.dart';

abstract class ISensor {
  Future<void> connect();
  Stream<EventData> pulser();
  bool inRange();
  CardioData getAnalisys();
}
