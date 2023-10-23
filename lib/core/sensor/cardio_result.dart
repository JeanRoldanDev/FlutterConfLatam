class CardioData {
  CardioData({
    required this.bpm,
    required this.spo2,
    required this.ech,
  });

  factory CardioData.zero() => CardioData(bpm: 0, spo2: 0, ech: 0);

  final double bpm;
  final double spo2;
  final double ech;
}
