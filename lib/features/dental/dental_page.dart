import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/core/core.dart';
import 'package:flutterconflatam/features/dental/bloc/dental_bloc.dart';
import 'package:flutterconflatam/features/dental/screen/dental_screen.dart';
import 'package:flutterconflatam/shared/shared.dart';

class DentalPage extends StatelessWidget {
  const DentalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => DentalBloc(
        humanSDK: context.read<IHuman>(),
        services: context.read<IService>(),
      )..add(LoadDataEv()),
      child: BlocListener<DentalBloc, DentalState>(
        listener: (context, state) {
          if (state is Error) {
            Toast.show(context, state.msg);
          }
        },
        child: const DentalScreen(),
      ),
    );
  }
}
