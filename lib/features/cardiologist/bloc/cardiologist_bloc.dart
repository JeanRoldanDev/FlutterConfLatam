import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/core/sensor/isensor.dart';

part 'cardiologist_event.dart';
part 'cardiologist_state.dart';

class CardiologistBloc extends Bloc<CardiologistEvent, CardiologistState> {
  CardiologistBloc({
    required this.sensor,
  }) : super(CardiologistInitial()) {
    on<CardiologistEvent>((event, emit) {});
  }

  final ISensor sensor;
}
