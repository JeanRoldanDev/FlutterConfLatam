import 'package:flutter/material.dart';
import 'package:flutterconflatam/shared/shared.dart';

class MenuDental extends StatelessWidget {
  const MenuDental({
    required this.onTap,
    super.key,
  });

  final void Function(int value) onTap;

  @override
  Widget build(BuildContext context) {
    return Menu(
      onTap: onTap,
      expanded: true,
      items: const [
        ItemMenu(
          text: 'Item1',
        ),
        ItemMenu(
          text: 'Item1',
        ),
        ItemMenu(
          text: 'Item1',
        ),
        ItemMenu(
          text: 'Item1',
        ),
        ItemMenu(
          text: 'Item1',
        ),
      ],
    );
  }
}
