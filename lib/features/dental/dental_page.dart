import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/app/style/ccolors.dart';
import 'package:flutterconflatam/core/human_sdk/human.dart';
import 'package:flutterconflatam/core/service/service.dart';
import 'package:flutterconflatam/features/dental/bloc/dental_bloc.dart';
import 'package:flutterconflatam/features/dental/screen/dental_screen.dart';

class DentalPage extends StatelessWidget {
  const DentalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => DentalBloc(
        humanSDK: context.read<IHuman>(),
        services: context.read<Services>(),
      )..add(LoadDataEv()),
      child: BlocListener<DentalBloc, DentalState>(
        listener: (context, state) {
          if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                content: Text(
                  state.msg,
                  style: TextStyle(color: CColors.background),
                ),
              ),
            );
          }
        },
        child: const DentalScreen(),
      ),
    );
  }
}
