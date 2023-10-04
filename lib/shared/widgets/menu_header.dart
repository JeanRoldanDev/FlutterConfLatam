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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'JeanRoldanDev',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: CColors.backgroundLight,
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Row(
              children: [
                ItemMenu(
                  assetsIcon: Imgs.iconDental,
                  text: 'Periodontograma',
                ),
                SizedBox(width: 10),
                ItemMenu(
                  assetsIcon: Imgs.iconHeart,
                  text: 'Cardiograma',
                ),
                SizedBox(width: 10),
                ItemMenu(
                  assetsIcon: Imgs.iconPhysiotherapy,
                  text: 'Fisioterapia',
                ),
                SizedBox(width: 10),
                ItemMenu(
                  assetsIcon: Imgs.iconElectrocardiogram,
                  text: 'Electrocardiograma',
                ),
                SizedBox(width: 10),
                ItemMenu(
                  assetsIcon: Imgs.iconSettings,
                  text: 'Config',
                ),
              ],
            ),
          ),
          const Row(
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

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    required this.assetsIcon,
    required this.text,
    super.key,
  });

  final String assetsIcon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: CColors.background,
        borderRadius: BorderRadius.circular(60),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetsIcon,
            color: Colors.white,
            width: 35,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
