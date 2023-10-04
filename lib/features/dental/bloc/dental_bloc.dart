import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/app/env.dart';
import 'package:flutterconflatam/core/human_sdk/human_interface.dart';
import 'package:flutterconflatam/core/human_sdk/human_ui.dart';

part 'dental_event.dart';
part 'dental_state.dart';

class DentalBloc extends Bloc<DentalEvent, DentalState> {
  DentalBloc({
    required this.humanSDK,
  }) : super(DentalInitial()) {
    on<LoadEv>(_onLoad);
  }

  final HumanSDK humanSDK;

  Future<void> _onLoad(LoadEv ev, Emitter<DentalState> emit) async {
    emit(DentalLoading());
    await humanSDK.create(
      HumanUI.modelDentalID,
      Env.instance.serverView3dDentalURL,
    );
    emit(DentalLoaded());
  }
}
