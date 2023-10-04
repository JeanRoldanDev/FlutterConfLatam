import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterconflatam/app/app.dart';
import 'package:flutterconflatam/shared/shared.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: CColors.background,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'JeanRoldanDev',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          _MenuPrincipal(),
          Row(
            children: [
              CircularIcon(
                icon: CupertinoIcons.person_alt,
              ),
              SizedBox(width: 5),
              CircularIcon(
                icon: CupertinoIcons.bell_fill,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _MenuPrincipal extends StatelessWidget {
  const _MenuPrincipal();

  @override
  Widget build(BuildContext context) {
    final pa = MediaQuery.of(context).size.width * 0.03;
    return const Padding(
      padding: EdgeInsets.symmetric(),
      child: Menu(
        items: [
          ItemMenu(
            assetsIcon: Imgs.iconDental,
            text: 'Periodontograma',
          ),
          ItemMenu(
            assetsIcon: Imgs.iconHeart,
            text: 'Cardiograma',
          ),
          ItemMenu(
            assetsIcon: Imgs.iconPhysiotherapy,
            text: 'Fisioterapia',
          ),
          ItemMenu(
            assetsIcon: Imgs.iconElectrocardiogram,
            text: 'Electrocardiograma',
          ),
          ItemMenu(
            assetsIcon: Imgs.iconSettings,
            text: 'Config',
          ),
        ],
      ),
    );
  }
}
