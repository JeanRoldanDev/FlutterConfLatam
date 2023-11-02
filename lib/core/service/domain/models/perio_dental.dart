class PerioDental {
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
}

class Analysis {
  const Analysis(this.probingDepth, this.gingivalMargin);

  static const Analysis zero = Analysis(0, 0);

  final int probingDepth;
  final int gingivalMargin;
}
