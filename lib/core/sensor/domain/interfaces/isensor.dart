import 'package:flutterconflatam/core/sensor/domain/models/cardio_result.dart';
import 'package:flutterconflatam/core/sensor/domain/models/event_data.dart';

abstract class ISensor {
  Future<void> connect({required String ip, required String port});
  Stream<EventData> pulser();
  bool inRange();
  CardioData getAnalisys();
}
