import 'package:flutter/material.dart';
import 'package:flutterconflatam/shared/shared.dart';
import 'package:material_symbols_icons/symbols.dart';

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
          icon: Symbols.ads_click_rounded,
          text: 'Select',
        ),
        ItemMenu(
          icon: Symbols.radiology,
          text: 'XRay',
        ),
        ItemMenu(
          icon: Symbols.remove,
          text: 'Delete',
        ),
      ],
    );
  }
}
