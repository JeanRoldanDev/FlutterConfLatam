import 'package:flutter/material.dart';
import 'package:flutterconflatam/core/human_sdk/human.dart';

class ToohImg extends StatelessWidget {
  const ToohImg({
    required this.tooth,
    required this.onTap,
    super.key,
  });

  final ItemDental tooth;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60,
        padding: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade700,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        alignment: Alignment.center,
        child: Image.asset(
          tooth.piece.vestibular,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
