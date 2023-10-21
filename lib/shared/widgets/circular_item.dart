import 'package:flutter/material.dart';
import 'package:flutterconflatam/app/style/ccolors.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    required this.icon,
    this.onTap,
    this.size,
    super.key,
  });

  final VoidCallback? onTap;
  final IconData icon;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: CircleAvatar(
        backgroundColor: CColors.backgroundLight,
        radius: size != null ? (size! / 1.3) : size,
        child: Icon(
          icon,
          color: Colors.white,
          size: size ?? 20,
        ),
      ),
    );
  }
}
