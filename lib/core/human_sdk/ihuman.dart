import 'package:flutterconflatam/core/human_sdk/models/object3d.dart';

abstract class IHuman {
  Future<void> create(String id, String url);
  Stream<Object3D> onSelect();
  Future<void> setXRay(bool status);
  Future<void> setEfectSelect(bool status);
}
