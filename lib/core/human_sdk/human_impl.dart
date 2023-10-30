import 'dart:async';
import 'dart:convert';
import 'dart:js' as js;

import 'package:flutterconflatam/core/human_sdk/human_ui.dart';
import 'package:flutterconflatam/core/human_sdk/ihuman.dart';
import 'package:flutterconflatam/core/human_sdk/models/models.dart';

class HumanoImpl implements IHuman {
  late js.JsObject? _humanJS;
  final StreamController<Object3D> _ctrlSelect = StreamController<Object3D>();
  final StreamController<void> _ctrlReady = StreamController<void>();
  Timer? _timer;
  double _currentTime = 0;

  @override
  Future<void> create(String id, String url) async {
    final dynamic contextInstanceJS = js.context['HumanAPI'];
    if (contextInstanceJS is js.JsFunction) {
      _humanJS = js.JsObject(contextInstanceJS, [id]);
      await _humanJS!.callMethod('on', ['human.ready', _ctrlReady.sink.add]);
      HumanUI.setURL(id, url);
      await _ctrlReady.stream.first;
      await _humanJS!.callMethod('send', ['timeline.pause']);
    }
  }

  @override
  Stream<Object3D> onSelect() {
    _humanJS!.callMethod('on', [
      'scene.objectsSelected',
      (dynamic ev) {
        final dataJsonStr = (js.context['JSON'] as js.JsObject)
            .callMethod('stringify', [ev as js.JsObject]).toString();
        final data = json.decode(dataJsonStr) as Map<String, dynamic>;
        final key = data.keys.first;
        final value = data[key] as bool;
        final resp = Object3D(id: key, status: value);
        print(resp.id);
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

  @override
  Future<void> setObjectData(String objectId) async {
    final dartObject = <String, dynamic>{
      'objectId': objectId,
      'tintColor': <int>[0, 1, 0],
      'brightness': 0.1,
      'saturation': -0.5,
      'contrast': 0.5,
      'opacity': 1.0,
    };

    final jsonJS = js.JsObject.jsify(dartObject);
    await _humanJS!.callMethod('send', ['scene.colorObject', jsonJS]);
  }

  @override
  Future<void> delObject(String objectId) async {
    final dartObject = <String, dynamic>{objectId: false};
    final jsonJS = js.JsObject.jsify(dartObject);
    await _humanJS!.callMethod('send', ['scene.showObjects', jsonJS]);
  }

  @override
  Future<void> pause() async {
    await _humanJS!.callMethod('send', ['timeline.pause']);
    _timer?.cancel();
  }

  @override
  Future<void> play() async {
    final dartObject = <String, dynamic>{'loop': true};
    final jsonJS = js.JsObject.jsify(dartObject);
    await _humanJS!.callMethod('send', ['timeline.play', jsonJS]);
  }

  @override
  Future<void> speed(double value) async {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      _currentTime += 0.01;
      if (_currentTime > 1) {
        _currentTime = 0;
      }
      final dartObject = <String, dynamic>{'time': _currentTime};
      final jsonJS = js.JsObject.jsify(dartObject);
      _humanJS!.callMethod('send', ['timeline.set', jsonJS]);
    });
  }

  @override
  Future<void> onSelectItemList(String objectId) async {
    final dartObject = <String, dynamic>{
      'objectId': objectId,
      'tintColor': <int>[0, 1, 0],
      'brightness': 0.1,
      'saturation': -0.5,
      'contrast': 0.5,
      'opacity': 1.0,
    };

    final jsonJS = js.JsObject.jsify(dartObject);
    await _humanJS!.callMethod('send', ['scene.colorObject', jsonJS]);
  }
}
