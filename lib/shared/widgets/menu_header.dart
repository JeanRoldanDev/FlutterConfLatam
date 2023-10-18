import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterconflatam/app/app.dart';
import 'package:flutterconflatam/features/cardiologist/cardiologist_page.dart';
import 'package:flutterconflatam/features/dental/dental_page.dart';
import 'package:flutterconflatam/shared/shared.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({
    required this.menuActive,
    super.key,
  });

  final int menuActive;

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
          _MenuPrincipal(menuActive: menuActive),
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

class _MenuPrincipal extends StatelessWidget {
  const _MenuPrincipal({required this.menuActive});

  final int menuActive;

  @override
  Widget build(BuildContext context) {
    return Menu(
      initialActive: menuActive,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<dynamic>(
              builder: (context) => const DentalPage(),
            ),
          );
        }
        if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<dynamic>(
              builder: (context) => const CardiologistPage(),
            ),
          );
        }
      },
      items: const [
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
      ],
    );
  }
}
