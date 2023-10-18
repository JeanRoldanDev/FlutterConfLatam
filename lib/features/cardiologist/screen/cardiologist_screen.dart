import 'package:flutter/material.dart';
import 'package:flutterconflatam/app/app.dart';
import 'package:flutterconflatam/features/cardiologist/widgets/widgets.dart';
import 'package:flutterconflatam/shared/shared.dart';

class CardiologistScreen extends StatelessWidget {
  const CardiologistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MenuHeader(menuActive: 1),
            const Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        LabelTitle(
                          'Cardiologist',
                          subText: 'Ckeck Your',
                        ),
                        PanelVisorHeart3D(),
                      ],
                    ),
                  ),
                  ItemsDataValue(),
                ],
              ),
            ),
            Container(
              height: 200,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
