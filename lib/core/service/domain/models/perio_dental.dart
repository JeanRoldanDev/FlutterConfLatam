import 'package:equatable/equatable.dart';

class PerioDental extends Equatable {
  const PerioDental({
    this.palatalDisto = Analysis.zero,
    this.palatalMiddle = Analysis.zero,
    this.palatalMesio = Analysis.zero,
    this.bucalDisto = Analysis.zero,
    this.bucalMiddle = Analysis.zero,
    this.bucalMesio = Analysis.zero,
  });

  final Analysis palatalDisto;
  final Analysis palatalMiddle;
  final Analysis palatalMesio;

  final Analysis bucalDisto;
  final Analysis bucalMiddle;
  final Analysis bucalMesio;

  @override
  List<Object> get props => [
        palatalDisto,
        palatalMiddle,
        palatalMesio,
        bucalDisto,
        bucalDisto,
        bucalMiddle,
        bucalMesio,
      ];
}

class Analysis extends Equatable {
  const Analysis(this.probingDepth, this.gingivalMargin);

  static const Analysis zero = Analysis(0, 0);

  final int probingDepth;
  final int gingivalMargin;

  @override
  List<Object> get props => [probingDepth, gingivalMargin];
}
