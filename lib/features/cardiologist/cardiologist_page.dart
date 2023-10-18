import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/features/cardiologist/bloc/cardiologist_bloc.dart';
import 'package:flutterconflatam/features/cardiologist/screen/Cardiologist_screen.dart';

class CardiologistPage extends StatelessWidget {
  const CardiologistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => CardiologistBloc(),
      child: BlocListener<CardiologistBloc, CardiologistState>(
        listener: (context, state) {},
        child: const CardiologistScreen(),
      ),
    );
  }
}
