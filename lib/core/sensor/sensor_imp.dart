import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutterconflatam/core/sensor/event_data.dart';
import 'package:flutterconflatam/core/sensor/isensor.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SensorImpl implements ISensor {
  late WebSocketChannel channel;

  static const String ip = '192.168.1.104';
  static const String port = '81';

  @override
  Future<void> connect() async {
    try {
      if (kDebugMode) {
        print('Loading');
      }
      final wsUrl = Uri.parse('ws://$port:$port');
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
      return EventData.fromJson(jsonData);
    });
  }
}
