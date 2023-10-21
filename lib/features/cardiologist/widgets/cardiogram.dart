import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Cardiogram extends StatefulWidget {
  const Cardiogram({required this.dataStream, required this.size, super.key});
  final Stream<int> dataStream;
  final Size size;

  @override
  State<Cardiogram> createState() => _CardiogramState();
}

class _CardiogramState extends State<Cardiogram> {
  final limitCount = 150;
  final sinPoints = <FlSpot>[];
  double xValue = 0;
  double step = 0.2;

  @override
  void initState() {
    widget.dataStream.listen((data) {
      while (sinPoints.length >= limitCount) {
        sinPoints.removeAt(0);
      }

      if (data == 0) {
        sinPoints.clear();
        return;
      }

      setState(() {
        sinPoints.add(FlSpot(xValue, data.toDouble()));
      });

      xValue++;
    });
    super.initState();
  }

  final grid = FlGridData(
    drawHorizontalLine: false,
    getDrawingVerticalLine: (value) {
      final status = value % 5 == 0;
      return FlLine(
        color: status ? Colors.red : Colors.black,
        strokeWidth: status ? 2 : 1,
      );
    },
    verticalInterval: 1,
  );

  @override
  Widget build(BuildContext context) {
    var minValue = 0.0;
    var maxValue = 1.0;

    if (sinPoints.isNotEmpty) {
      final li = sinPoints.map<double>((e) => e.y).toList();
      minValue =
          li.reduce((value, element) => value < element ? value : element);
      maxValue =
          li.reduce((value, element) => value > element ? value : element);
    }

    return sinPoints.isNotEmpty
        ? AspectRatio(
            aspectRatio: 1.5,
            child: LineChart(
              LineChartData(
                titlesData: const FlTitlesData(
                  bottomTitles: AxisTitles(),
                  topTitles: AxisTitles(),
                ),
                gridData: grid,
                lineTouchData: const LineTouchData(enabled: false),
                borderData: FlBorderData(show: false),
                minY: minValue,
                maxY: maxValue.clamp(2000, 2500),
                minX: sinPoints.first.x,
                maxX: sinPoints.last.x,
                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    HorizontalLine(y: 2200),
                    HorizontalLine(y: 2100),
                  ],
                ),
                lineBarsData: [
                  LineChartBarData(
                    color: Colors.black,
                    dotData: const FlDotData(show: false),
                    isCurved: true,
                    curveSmoothness: 0.2,
                    gradient: LinearGradient(
                      colors: [Colors.red.withOpacity(0), Colors.black],
                      stops: const [0.01, 0.1],
                    ),
                    barWidth: 3,
                    spots: sinPoints,
                  ),
                ],
              ),
              // duration: const Duration(milliseconds: 120),
              // curve: Curves.fastOutSlowIn,
            ),
          )
        : const SizedBox.shrink();
  }

  FlTitlesData get titlesData2 => const FlTitlesData(
        rightTitles: AxisTitles(),
        topTitles: AxisTitles(),
        bottomTitles: AxisTitles(),
        leftTitles: AxisTitles(
          axisNameSize: 0.1,
          sideTitles: SideTitles(
            reservedSize: 30,
            showTitles: true,
            interval: 1,
          ),
        ),
      );
}
