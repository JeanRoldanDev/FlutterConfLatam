import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/app/app.dart';
import 'package:flutterconflatam/features/cardiologist/cardiologist_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: Injections.all,
      child: MaterialApp(
        title: 'Flutter Conf 2023',
        theme: ThemeApp.getDefault,
        debugShowCheckedModeBanner: false,
        home: const CardiologistPage(),
      ),
    );
  }
}
