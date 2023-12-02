import 'package:equatable/equatable.dart';

class Object3D extends Equatable {
  const Object3D({
    required this.id,
    required this.status,
  });

  final String id;
  final bool status;

  @override
  List<Object> get props => [id, status];
}
