import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/app/config/env.dart';
import 'package:flutterconflatam/core/human_sdk/human.dart';
import 'package:flutterconflatam/core/sensor/sensor.dart';

part 'cardiologist_event.dart';
part 'cardiologist_state.dart';

typedef ECardo = Emitter<CardiologistState>;

class CardiologistBloc extends Bloc<CardiologistEvent, CardiologistState> {
  CardiologistBloc({
    required this.sensor,
    required this.humanSDK,
  }) : super(const Initial()) {
    on<ReadPulserEv>(_onReadPulser);
    on<UpdateResultEv>(_onUpdateResult);
    on<ViewChartEv>(_onViewChart);
  }

  final ISensor sensor;
  final IHuman humanSDK;

  final _cardioStreamCtrl = StreamController<int>();
  Stream<int> get streamPulser => _cardioStreamCtrl.stream;
  DateTime _futureTime = DateTime.now();

  bool viewDataResulta = false;

  Future<void> analisis() async {
    if (sensor.inRange()) {
      final now = DateTime.now();
      final date1 = now.millisecondsSinceEpoch ~/ 1000;
      final date2 = _futureTime.millisecondsSinceEpoch ~/ 1000;
      if (date1 >= date2) {
        _futureTime = now.add(const Duration(seconds: 2));
        final cardioData = sensor.getAnalisys();
        if (viewDataResulta & (cardioData != CardioData.zero)) {
          add(UpdateResultEv(cardioData));
          await humanSDK.play();
        } else {
          add(UpdateResultEv(CardioData.zero));
          await humanSDK.pause();
        }
      }
    }
  }

  Future<void> _onReadPulser(ReadPulserEv ev, ECardo emit) async {
    try {
      emit(const Loading());
      await sensor.connect(ip: '192.168.43.83', port: '81');
    } catch (e) {
      emit(const Error('Error al conectar'));
      return;
    }

    await humanSDK.create(
      HumanUI.modelHeartID,
      Env.instance.serverView3dHeartURL,
    );
    emit(const Loaded());
    sensor.pulser().listen((dat) {
      if (dat.event == 'Pulser') {
        _cardioStreamCtrl.add(dat.value);
        if (dat.value == 0) {
          add(UpdateResultEv(CardioData.zero));
          humanSDK.pause();
        }
        analisis();
      }
    });
  }

  Future<void> _onViewChart(ViewChartEv ev, ECardo emit) async {
    emit(const Success());
    viewDataResulta = true;
  }

  Future<void> _onUpdateResult(UpdateResultEv ev, ECardo emit) async {
    emit(HasResult(cardioData: ev.data));
  }
}
