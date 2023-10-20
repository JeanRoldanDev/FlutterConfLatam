import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/app/app.dart';
import 'package:flutterconflatam/core/human_sdk/human.dart';
import 'package:flutterconflatam/core/sensor/isensor.dart';
import 'package:flutterconflatam/core/sensor/sensor_imp.dart';
import 'package:flutterconflatam/core/service/service.dart';
import 'package:flutterconflatam/features/cardiologist/cardiologist_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IHuman>(create: (context) => HumanoImpl()),
        RepositoryProvider<ISensor>(create: (context) => SensorImpl()),
        RepositoryProvider<Services>(
          create: (context) => Services(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Conf 2023',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: Fonts.poppins,
          useMaterial3: true,
        ),
        home: const CardiologistPage(),
        // home: const Comunica(),
      ),
    );
  }
}
