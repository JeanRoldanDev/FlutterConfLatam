import 'package:flutterconflatam/core/service/service.dart';

class ServiceImpl implements IService {
  @override
  Future<List<ItemDental>> getDentalRegister() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return ItemDental.all;
  }

  @override
  Future<void> getDetails(int registerId) async {
    throw UnimplementedError();
  }
}
