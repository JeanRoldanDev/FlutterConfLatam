import 'package:flutterconflatam/core/sensor/cardio_result.dart';
import 'package:flutterconflatam/core/sensor/event_data.dart';

abstract class ISensor {
  Future<void> connect();
  Stream<EventData> pulser();
  bool inRange();
  CardioData getAnalisys();
}
