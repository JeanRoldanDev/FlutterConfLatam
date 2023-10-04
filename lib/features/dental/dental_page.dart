// ignore_for_file: cascade_invocations, unnecessary_lambdas, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/core/human_sdk/human_interface.dart';
import 'package:flutterconflatam/features/dental/bloc/dental_bloc.dart';
import 'package:flutterconflatam/features/dental/screen/dental_screen.dart';

class DentalPage extends StatelessWidget {
  const DentalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => DentalBloc(
        humanSDK: context.read<HumanSDK>(),
      )..add(LoadEv()),
      child: const DentalScreen(),
    );
  }
}
