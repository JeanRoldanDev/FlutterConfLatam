import 'package:equatable/equatable.dart';

class PieceDental extends Equatable {
  const PieceDental({
    required this.id,
    required this.cod,
    required this.name,
    required this.position,
    required this.vestibular,
    required this.lingual,
    required this.incisal,
  });

  final String id;
  final int cod;
  final String name;
  final String position;
  final String vestibular;
  final String lingual;
  final String incisal;

  @override
  List<Object> get props => [
        id,
        cod,
        name,
        position,
        vestibular,
        lingual,
        incisal,
      ];
}
