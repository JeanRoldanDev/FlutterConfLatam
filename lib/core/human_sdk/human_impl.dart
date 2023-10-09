import 'dart:async';
import 'dart:convert';
import 'dart:js' as js;

import 'package:flutterconflatam/core/human_sdk/human_ui.dart';
import 'package:flutterconflatam/core/human_sdk/ihuman.dart';
import 'package:flutterconflatam/core/human_sdk/models/models.dart';

class HumanoImpl implements IHuman {
  HumanoImpl();

  late js.JsObject? _humanJS;
  final StreamController<Object3D> _ctrlSelect = StreamController<Object3D>();
  final StreamController<void> _ctrlReady = StreamController<void>();

  @override
  Future<void> create(String id, String url) async {
    final dynamic contextInstanceJS = js.context['HumanAPI'];
    if (contextInstanceJS is js.JsFunction) {
      _humanJS = js.JsObject(contextInstanceJS, [id]);
      _humanJS!.callMethod('on', ['human.ready', _ctrlReady.sink.add]);
      HumanUI.setURL(id, url);
      await _ctrlReady.stream.first;
      await Future<void>.delayed(const Duration(seconds: 1));
    }
  }

  @override
  Stream<Object3D> onSelect() {
    _humanJS!.callMethod('on', [
      'scene.objectsSelected',
      (dynamic ev) {
        // final jsObject = js.JsObject.fromBrowserObject(data as Object);
        final dataJsonStr = (js.context['JSON'] as js.JsObject)
            .callMethod('stringify', [ev as js.JsObject]).toString();
        final data = json.decode(dataJsonStr) as Map<String, dynamic>;
        final key = data.keys.first;
        final value = data[key] as bool;
        final resp = Object3D(id: key, status: value);
        _ctrlSelect.sink.add(resp);
      }
    ]);
    return _ctrlSelect.stream;
  }

  @override
  Future<void> setXRay(bool status) async {
    final ev = status ? 'scene.enableXray' : 'scene.disableXray';
    await _humanJS!.callMethod('send', [ev, null]);
  }

  @override
  Future<void> setEfectSelect(bool status) async {
    final ev = status ? 'scene.enableHighlight' : 'scene.disableHighlight';
    await _humanJS!.callMethod('send', [ev, null]);
  }
}
