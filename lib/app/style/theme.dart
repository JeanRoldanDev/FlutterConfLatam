import 'package:flutter/material.dart';
import 'package:flutterconflatam/app/app.dart';

class ThemeApp {
  static ThemeData get getDefault => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: Fonts.poppins,
        useMaterial3: true,
      );
}
