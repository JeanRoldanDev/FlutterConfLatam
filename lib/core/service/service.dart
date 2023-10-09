import 'package:flutterconflatam/core/human_sdk/data/item_dental.dart';

class Services {
  Future<List<ItemDental>> getDentalRegister() async {
    await Future<dynamic>.delayed(const Duration(seconds: 2));
    return ItemDental.all;
  }

  Future<void> getDetails(int registerId) async {}
}
