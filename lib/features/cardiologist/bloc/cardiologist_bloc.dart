import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/app/env.dart';
import 'package:flutterconflatam/core/human_sdk/human.dart';
import 'package:flutterconflatam/core/sensor/cardio_result.dart';
import 'package:flutterconflatam/core/sensor/isensor.dart';

part 'cardiologist_event.dart';
part 'cardiologist_state.dart';

typedef ECardo = Emitter<CardiologistState>;

class CardiologistBloc extends Bloc<CardiologistEvent, CardiologistState> {
  CardiologistBloc({
    required this.sensor,
    required this.humanSDK,
  }) : super(Initial()) {
    on<ReadPulserEv>(_onReadPulser);
    on<ResetPulserEv>(_onResetPulser);
    on<UpdateResultEv>(_onUpdateResult);
    on<ViewChartEv>(_onViewChart);
  }

  final ISensor sensor;
  final IHuman humanSDK;

  final _cardioStreamCtrl = StreamController<int>();
  Stream<int> get streamPulser => _cardioStreamCtrl.stream;
  DateTime _futureTime = DateTime.now();

  Future<void> analisis(int data) async {
    if (sensor.inRange()) {
      await humanSDK.play();
      final now = DateTime.now();
      final date1 = now.millisecondsSinceEpoch ~/ 1000;
      final date2 = _futureTime.millisecondsSinceEpoch ~/ 1000;
      if (date1 >= date2) {
        _futureTime = now.add(const Duration(seconds: 2));
        final cardioData = sensor.getAnalisys();
        add(UpdateResultEv(cardioData));
        if (kDebugMode) {
          print('YA SE PUEDE ANALIZAR LA DATA ${cardioData.bpm}');
        }
      }
    }
  }

  Future<void> _onReadPulser(ReadPulserEv ev, ECardo emit) async {
    try {
      emit(Loading());
      await sensor.connect();
    } catch (e) {
      emit(Error('Error al conectar'));
      return;
    }

    await humanSDK.create(
      HumanUI.modelHeartID,
      Env.instance.serverView3dHeartURL,
    );
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(Loaded());
    sensor.pulser().listen((dat) {
      if (dat.event == 'Pulser') {
        _cardioStreamCtrl.add(dat.value);
        analisis(dat.value);
      }
    });
  }

  Future<void> _onViewChart(ViewChartEv ev, ECardo emit) async {
    emit(Success());
  }

  Future<void> _onUpdateResult(UpdateResultEv ev, ECardo emit) async {
    emit(HasResult(ev.data));
  }

  Future<void> _onResetPulser(ResetPulserEv ev, ECardo emit) async {
    await humanSDK.play();
    await humanSDK.speed(0.5);
    await Future<void>.delayed(const Duration(seconds: 5));
    await humanSDK.pause();
  }
}
