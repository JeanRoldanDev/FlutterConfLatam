import 'package:flutter/material.dart';
import 'package:flutterconflatam/app/app.dart';
import 'package:flutterconflatam/features/cardiologist/widgets/widgets.dart';
import 'package:flutterconflatam/shared/shared.dart';

class CardiologistScreen extends StatefulWidget {
  const CardiologistScreen({super.key});

  @override
  State<CardiologistScreen> createState() => _CardiologistScreenState();
}

class _CardiologistScreenState extends State<CardiologistScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.15,
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MenuHeader(menuActive: 1),
            Expanded(
              child: Row(
                children: [
                  TitleCardio3DActions(),
                  ItemsDataValue(),
                ],
              ),
            ),
            CardiogramPanel(),
          ],
        ),
      ),
    );
  }
}
