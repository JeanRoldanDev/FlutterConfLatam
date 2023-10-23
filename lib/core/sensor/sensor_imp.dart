import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutterconflatam/core/sensor/cardio_result.dart';
import 'package:flutterconflatam/core/sensor/event_data.dart';
import 'package:flutterconflatam/core/sensor/isensor.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SensorImpl implements ISensor {
  late WebSocketChannel channel;

  static const String ip = '192.168.43.83';
  static const String port = '81';
  static const int rangeInit = 1500;
  static const int rangeEnd = 3000;
  static const int patronR = 2000;

  final dataAnalisys = <int>[];

  @override
  Future<void> connect() async {
    try {
      if (kDebugMode) {
        print('Loading');
      }
      final wsUrl = Uri.parse('ws://$ip:$port');
      channel = WebSocketChannel.connect(wsUrl);
      await channel.ready;
      if (kDebugMode) {
        print('Conectado');
      }
    } catch (e, t) {
      if (kDebugMode) {
        print('APP ERROR: $e\n$t');
      }
      rethrow;
    }
  }

  @override
  Stream<EventData> pulser() {
    return channel.stream.asyncMap<EventData>((event) {
      final jsonData = json.decode(event.toString()) as Map<String, dynamic>;
      final eventData = EventData.fromJson(jsonData);
      if (eventData.event == 'Pulser') {
        processAnalisys(eventData.value);
      }
      return eventData;
    });
  }

  void processAnalisys(int data) {
    while (dataAnalisys.length >= 150) {
      dataAnalisys.removeAt(0);
    }

    if (data == 0) {
      dataAnalisys.clear();
      return;
    }

    dataAnalisys.add(data);
  }

  @override
  bool inRange() {
    if (dataAnalisys.length < 150) return false;
    for (final el in dataAnalisys) {
      if (el < rangeInit || el > rangeEnd) {
        return false;
      }
    }
    return true;
  }

  @override
  CardioData getAnalisys() {
    const patronR = 2000;
    var cont = 0;
    var ban = false;
    final dataPat = <int>[];

    var r1 = 0;
    final result = <double>[];
    for (final el in dataAnalisys) {
      if (el >= patronR) {
        ban = true;
        dataPat.add(el);
      }

      if (ban && el <= patronR) {
        ban = false;
        final pointUp = dataPat.reduce((max, number) {
          return number >= max ? number : max;
        });
        final positionItem = dataPat.indexWhere((item) => item == pointUp);
        final positionPoint = dataPat.length - positionItem;
        final pointFinal = cont - positionPoint;
        dataPat.clear();
        final calss = 1500 / (pointFinal - r1);
        r1 = pointFinal;
        if (calss != double.infinity) {
          result.add(calss);
        }
      }
      cont++;
    }

    var media = 0.0;
    if (result.isNotEmpty) {
      result.removeWhere((element) => element <= 50 || element >= 200);
      if (result.isNotEmpty) {
        media = result.reduce((a, b) => a + b) / result.length;
      }
    }

    final spo2 = ((110.0 - 0.44 * media) / 100).clamp(0, 1).toDouble();
    final ech = (media + (spo2 * 100)) / 2;

    return CardioData(
      bpm: double.parse(media.toStringAsFixed(2)),
      spo2: spo2,
      ech: ech,
    );
  }
}
