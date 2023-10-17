import 'package:flutter/material.dart';
import 'package:flutterconflatam/app/app.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    required this.icon,
    this.onTap,
    super.key,
  });

  final VoidCallback? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: CColors.backgroundLight,
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
