import 'package:flutter/material.dart';
import 'package:flutterconflatam/app/style/ccolors.dart';
import 'package:flutterconflatam/core/core.dart';
import 'package:flutterconflatam/shared/visor_3d/shims/dart_ui.dart' as ui;

class Visor3DServer extends StatefulWidget {
  const Visor3DServer({
    required this.id,
    required this.apiKey,
    super.key,
  });

  final String apiKey;
  final String id;

  @override
  State<Visor3DServer> createState() => _Visor3DServerState();
}

class _Visor3DServerState extends State<Visor3DServer> {
  final globalKey = GlobalKey();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    HumanUI.setToken(widget.apiKey);
    final divElement = HumanUI.createView(widget.id);
    ui.platformViewRegistry.registerViewFactory(
      'visorView3DModel${widget.key}',
      (_) => divElement,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        foregroundDecoration: BoxDecoration(
          border: Border.all(
            color: CColors.background,
            width: 2,
          ),
        ),
        child: HtmlElementView(viewType: 'visorView3DModel${widget.key}'),
      ),
    );
  }
}
