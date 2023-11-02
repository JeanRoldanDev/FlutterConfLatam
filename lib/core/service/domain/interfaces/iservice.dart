import 'package:flutterconflatam/core/service/domain/models/models.dart';

abstract class IService {
  Future<List<ItemDental>> getDentalRegister();
  Future<void> getDetails(int registerId);
}
