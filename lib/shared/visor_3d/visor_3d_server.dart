// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutterconflatam/shared/visor_3d/shims/dart_ui.dart' as ui;

class Visor3DServer extends StatefulWidget {
  const Visor3DServer({
    required this.url,
    required this.apiKey,
    super.key,
  });

  final String url;
  final String apiKey;

  @override
  State<Visor3DServer> createState() => _Visor3DServerState();
}

class _Visor3DServerState extends State<Visor3DServer> {
  final globalKey = GlobalKey();

  @override
  void initState() {
    _metaToken();
    _createVideoElement();
    super.initState();
  }

  void _metaToken() {
    final meta = html.MetaElement()
      ..content = widget.apiKey
      ..name = 'secutiry-token-visor';
    html.document.head?.append(meta);
  }

  html.DivElement _div() {
    final div = html.DivElement();
    div.style.height = '55px';
    div.style.width = '100%';
    div.style.position = 'absolute';
    div.style.zIndex = '1';
    div.style.background = 'black';
    return div;
  }

  void _createVideoElement() {
    final divContent = html.DivElement();
    divContent.style.height = '100%';
    divContent.style.width = '100%';
    divContent.style.position = 'relative';

    final iframe = html.IFrameElement()
      ..src = widget.url
      ..id = 'myWidget'
      ..style.border = 'none'
      ..style.background = 'black'
      ..style.margin = '0px'
      ..style.padding = '0px'
      ..style.width = '100%'
      ..style.height = '100%';

    final div1 = _div();
    div1.style.top = '0px';

    final div2 = _div();
    div2.style.bottom = '0px';

    divContent
      ..append(iframe)
      ..append(div1)
      ..append(div2);

    ui.platformViewRegistry.registerViewFactory(
      'visorView3DModel',
      (_) => divContent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: HtmlElementView(viewType: 'visorView3DModel'),
    );
  }
}
