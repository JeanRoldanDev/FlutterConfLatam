import 'package:equatable/equatable.dart';

class CardioData extends Equatable {
  const CardioData({
    required this.bpm,
    required this.spo2,
    required this.ech,
  });

  static const zero = CardioData(bpm: 0, spo2: 0, ech: 0);

  final double bpm;
  final double spo2;
  final double ech;

  @override
  List<Object> get props => [
        bpm,
        spo2,
        ech,
      ];
}
