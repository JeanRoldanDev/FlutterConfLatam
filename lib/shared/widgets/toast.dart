import 'package:flutter/material.dart';
import 'package:flutterconflatam/app/style/ccolors.dart';

class Toast {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          message,
          style: TextStyle(color: CColors.background),
        ),
      ),
    );
  }
}
