// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterconflatam/app/app.dart';
import 'package:flutterconflatam/comunica.dart';
import 'package:flutterconflatam/features/cardiologist/widgets/cardiogram.dart';
import 'package:flutterconflatam/features/cardiologist/widgets/data.dart';
import 'package:flutterconflatam/features/cardiologist/widgets/widgets.dart';
import 'package:flutterconflatam/shared/shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CardiologistScreen extends StatefulWidget {
  const CardiologistScreen({super.key});

  @override
  State<CardiologistScreen> createState() => _CardiologistScreenState();
}

class _CardiologistScreenState extends State<CardiologistScreen> {
  final streamCtrl = StreamController<int>();
  late WebSocketChannel channel;

  Future<void> holis() async {
    for (final el in dataTest) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      streamCtrl.add(el);
      print(el);
    }
  }

  @override
  void initState() {
    holis();
    // conectar();
    super.initState();
  }

  Future<void> conectar() async {
    try {
      print('Loading');
      final wsUrl = Uri.parse('ws://192.168.1.104:81');
      channel = WebSocketChannel.connect(wsUrl);
      await channel.ready;
      print('cargado');
      channel.stream.listen(
        listem,
      );
    } catch (e) {
      print('ERORRRRRRR $e');
    }
  }

  void listem(dynamic data) {
    final jsonData = json.decode(data.toString()) as Map<String, dynamic>;
    final ev = EventData.fromJson(jsonData);
    if (ev.event == 'Pulser') {
      streamCtrl.add(ev.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MenuHeader(menuActive: 1),
            const Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        LabelTitle(
                          'Cardiologist',
                          subText: 'Ckeck Your',
                        ),
                        PanelVisorHeart3D(),
                      ],
                    ),
                  ),
                  ItemsDataValue(),
                ],
              ),
            ),
            Container(
              height: 200,
              color: Colors.white,
              child: LayoutBuilder(
                builder: (context, box) {
                  return SizedBox(
                    width: box.maxWidth,
                    height: box.maxHeight,
                    child: Cardiogram(
                      dataStream: streamCtrl.stream,
                      size: Size(box.maxWidth, box.maxHeight),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
