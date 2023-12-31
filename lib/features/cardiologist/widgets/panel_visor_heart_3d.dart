import 'package:flutter/material.dart';
import 'package:flutterconflatam/app/config/env.dart';
import 'package:flutterconflatam/core/human_sdk/domain/ui/human_ui.dart';
import 'package:flutterconflatam/shared/shared.dart';

class PanelVisorHeart3D extends StatelessWidget {
  const PanelVisorHeart3D({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ColoredBox(
        color: Colors.blue.withOpacity(0.5),
        child: Visor3DServer(
          id: HumanUI.modelHeartID,
          apiKey: Env.instance.apiKey,
        ),
      ),
    );
  }
}
