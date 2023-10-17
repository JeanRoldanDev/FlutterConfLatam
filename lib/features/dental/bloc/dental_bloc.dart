import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/app/env.dart';
import 'package:flutterconflatam/core/human_sdk/human.dart';
import 'package:flutterconflatam/core/service/service.dart';

part 'dental_event.dart';
part 'dental_state.dart';

typedef DEmit = Emitter<DentalState>;

class DentalBloc extends Bloc<DentalEvent, DentalState> {
  DentalBloc({
    required this.services,
    required this.humanSDK,
  }) : super(const DentalInitial([])) {
    on<LoadDataEv>(_onLoadData);
    on<Load3DModelEv>(_onLoad3DModel);
    on<XRay3DEv>(_onXRay3D);
    on<Select3DEv>(_onSelect3D);
    on<DelectEv>(_onDelect);
  }

  final IHuman humanSDK;
  final Services services;

  String? toothSelect;

  Future<void> _onLoadData(LoadDataEv ev, DEmit emit) async {
    emit(const DentalLoading([]));
    final data = await services.getDentalRegister();
    emit(DentalLoaded(data));
    await Future<dynamic>.delayed(const Duration(seconds: 1));
    add(Load3DModelEv());
  }

  Future<void> _onLoad3DModel(Load3DModelEv ev, DEmit emit) async {
    emit(Model3DLoading(state.data));
    await humanSDK.create(
      HumanUI.modelDentalID,
      Env.instance.serverView3dDentalURL,
    );
    humanSDK.onSelect().listen((event) {
      if (!event.status) {
        toothSelect = null;
      } else {
        toothSelect = event.id;
      }
    });

    for (final el in state.data) {
      if (el.perio != null) {
        await humanSDK.setObjectData(el.piece.id);
      }
    }

    emit(Model3DLoaded(state.data));
  }

  Future<void> _onXRay3D(XRay3DEv ev, DEmit emit) async {
    await humanSDK.setXRay(true);
  }

  Future<void> _onSelect3D(Select3DEv ev, DEmit emit) async {
    await humanSDK.setXRay(false);
  }

  Future<void> _onDelect(DelectEv ev, DEmit emit) async {
    if (toothSelect == null) {
      emit(Error('Seleccione una pieza dental dentro visor', state.data));
    } else {
      await humanSDK.delObject(toothSelect!);
    }
  }
}
