// ignore_for_file: cascade_invocations
import 'package:flutter/material.dart';

class Item {
  Item({required this.child, this.childPallette});

  final Widget child;
  final Widget? childPallette;
}

class ListViewRadius extends StatelessWidget {
  const ListViewRadius({
    required this.itemCount,
    required this.itemBuilder,
    this.colorItem = Colors.black,
    super.key,
  });

  final Color colorItem;
  final int itemCount;
  final Item Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    final list = <Item>[];
    for (var i = 0; i < itemCount; i++) {
      list.add(itemBuilder.call(context, i));
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _RowItem(
          index: index,
          color: colorItem,
          childPallette: list[index].childPallette,
          nextItemPalette:
              index == list.length - 1 ? null : list[index + 1].childPallette,
          child: list[index].child,
        );
      },
    );
  }
}

const _marg = 5.0;
const _r0 = 30.0;
const _r1 = _r0 - 15;
const _r2 = _r0 - 10;

const _espW = 15.0;
const _espH = 10.0;

const _sizePallete = Size(70, 55);

class _RowItem extends StatelessWidget {
  const _RowItem({
    required this.index,
    required this.color,
    this.nextItemPalette,
    this.child,
    this.childPallette,
  });

  final int index;
  final Color color;
  final Widget? nextItemPalette;
  final Widget? child;
  final Widget? childPallette;

  @override
  Widget build(BuildContext context) {
    const margin = EdgeInsets.only(bottom: _marg);
    return Container(
      margin: margin,
      child: Column(
        children: [
          if (index == 0 && childPallette != null)
            Align(
              alignment: Alignment.bottomRight,
              child: _Pallet(
                color: color,
                nextItemPalette: childPallette,
              ),
            ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              // ========  BODYITEM ============
              ClipPath(
                clipper: _ItemClipper(
                  hasPallete: childPallette != null,
                  hasNextItemPalette: nextItemPalette != null,
                ),
                child: Container(
                  height: 125,
                  color: color,
                  child: child,
                ),
              ),
              // ========  BODYITEM ============
              if (nextItemPalette != null)
                Positioned(
                  right: 0,
                  bottom: -_marg,
                  child: _Pallet(
                    color: color,
                    nextItemPalette: nextItemPalette,
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}

class _Pallet extends StatelessWidget {
  const _Pallet({
    required this.color,
    required this.nextItemPalette,
  });

  final Color color;
  final Widget? nextItemPalette;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _PalletClipper(),
      child: Container(
        width: _sizePallete.width,
        height: _sizePallete.height,
        color: color,
        padding: const EdgeInsets.only(
          top: _marg,
          left: _r2 + _marg,
          bottom: _marg,
        ),
        child: nextItemPalette,
      ),
    );
  }
}

class _ItemClipper extends CustomClipper<Path> {
  _ItemClipper({this.hasPallete = false, this.hasNextItemPalette = false});

  final bool hasPallete;
  final bool hasNextItemPalette;

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path();

    // Pallet
    path.moveTo(_r0, 0);
    if (hasPallete) {
      path.lineTo(w, 0);
    } else {
      path.lineTo(w - _r0, 0);
      path.arcToPoint(
        Offset(w, _r0),
        radius: const Radius.circular(_r0),
      );
    }

    // Pallet next element
    if (hasNextItemPalette) {
      path.lineTo(w, h - (_r2 * 2) - _espH - _r1);
      path.arcToPoint(
        Offset(w - _r1, h - (_r2 * 2) - _espH),
        radius: const Radius.circular(_r1),
      );
      path.lineTo(w - _r1 - _espW, h - (_r2 * 2) - _espH);
      path.arcToPoint(
        Offset(w - _r1 - _espW - _r2, h - _r2 - _espH),
        radius: const Radius.circular(_r2),
        clockwise: false,
      );
      path.lineTo(w - _r1 - _espW - _r2, h - _r2);

      path.arcToPoint(
        Offset(w - _r1 - _espW - (_r2 * 2), h),
        radius: const Radius.circular(_r2),
      );
    } else {
      path.lineTo(w, h - _r0);
      path.arcToPoint(
        Offset(w - _r0, h),
        radius: const Radius.circular(_r0),
      );
    }

    // Body
    path.lineTo(_r0, h);
    path.arcToPoint(
      Offset(0, h - _r0),
      radius: const Radius.circular(_r0),
    );
    path.lineTo(0, _r0);
    path.arcToPoint(
      const Offset(_r2, 0),
      radius: const Radius.circular(_r0),
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class _PalletClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path();
    path.moveTo(0, h);
    path.arcToPoint(
      Offset(_r2 + _marg, h - _r2),
      radius: const Radius.circular(_r0),
      clockwise: false,
    );
    path.lineTo(_r2 + _marg, _marg + _r2);
    path.arcToPoint(
      const Offset(_r2 * 2, _marg),
      radius: const Radius.circular(_r2),
    );
    path.lineTo((_r2 * 2) + _espW, _marg);
    path.arcToPoint(
      Offset(w, _marg + _r1),
      radius: const Radius.circular(_r1),
    );
    path.lineTo(w, h);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
