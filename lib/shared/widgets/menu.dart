import 'package:flutter/material.dart';
import 'package:flutterconflatam/app/app.dart';

class Menu extends StatefulWidget {
  const Menu({
    required this.items,
    this.initialActive = 0,
    this.expanded = false,
    this.onTap,
    super.key,
  });

  final List<ItemMenu> items;
  final void Function(int index)? onTap;
  final int initialActive;
  final bool expanded;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late int _indexActive;

  @override
  void initState() {
    _indexActive = widget.initialActive;
    super.initState();
  }

  void onTap(int index) {
    setState(() {
      _indexActive = index;
    });
    widget.onTap?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: CColors.backgroundLight,
        borderRadius: BorderRadius.circular(60),
      ),
      child: Row(
        mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
        children: [
          if (widget.expanded)
            for (int x = 0; x < widget.items.length; x++) ...[
              Expanded(
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: () => onTap(x),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: x == _indexActive
                          ? Colors.grey.shade700
                          : CColors.backgroundLight,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: widget.items[x],
                  ),
                ),
              )
            ]
          else
            for (int x = 0; x < widget.items.length; x++) ...[
              InkWell(
                splashColor: Colors.white,
                onTap: () => onTap(x),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: x == _indexActive
                        ? Colors.grey.shade700
                        : CColors.backgroundLight,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: widget.items[x],
                ),
              )
            ]
        ],
      ),
    );
  }
}

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    this.text,
    this.assetsIcon,
    this.icon,
    super.key,
  });

  final String? assetsIcon;
  final String? text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null)
          Icon(
            icon,
            color: Colors.white,
          ),
        if (assetsIcon != null)
          Image.asset(
            assetsIcon!,
            color: Colors.white,
            width: 35,
          ),
        if (assetsIcon != null) const SizedBox(width: 5),
        if (text != null)
          Text(
            text!,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
      ],
    );
  }
}
