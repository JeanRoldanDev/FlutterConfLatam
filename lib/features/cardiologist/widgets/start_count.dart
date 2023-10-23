import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/features/cardiologist/bloc/cardiologist_bloc.dart';

class StartCount extends StatefulWidget {
  const StartCount({
    super.key,
  });

  @override
  State<StartCount> createState() => _StartCountState();
}

class _StartCountState extends State<StartCount> {
  int count = 10;

  void startCountdown() {
    if (count > 0) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          count--;
        });
        startCountdown();
      });
    }

    if (count == 0) {
      context.read<CardiologistBloc>().add(ViewChartEv());
    }
  }

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$count',
      style: const TextStyle(color: Colors.white, fontSize: 20),
    );
  }
}
