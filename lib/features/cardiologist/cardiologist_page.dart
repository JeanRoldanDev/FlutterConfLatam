import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/app/style/ccolors.dart';
import 'package:flutterconflatam/core/sensor/isensor.dart';
import 'package:flutterconflatam/features/cardiologist/bloc/cardiologist_bloc.dart';
import 'package:flutterconflatam/features/cardiologist/screen/Cardiologist_screen.dart';

class CardiologistPage extends StatelessWidget {
  const CardiologistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => CardiologistBloc(
        sensor: context.read<ISensor>(),
      ),
      child: BlocListener<CardiologistBloc, CardiologistState>(
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
        child: const CardiologistScreen(),
      ),
    );
  }
}
