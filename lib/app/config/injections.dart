import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/core/core.dart';

class Injections {
  static List<RepositoryProvider<dynamic>> get all => [
        RepositoryProvider<IHuman>(create: (_) => HumanoImpl()),
        RepositoryProvider<ISensor>(create: (_) => SensorImpl()),
        RepositoryProvider<IService>(create: (_) => ServiceImpl()),
      ];
}
