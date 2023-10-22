import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/features/cardiologist/bloc/cardiologist_bloc.dart';

class Cardiogram extends StatefulWidget {
  const Cardiogram({
    super.key,
  });

  @override
  State<Cardiogram> createState() => _CardiogramState();
}

class _CardiogramState extends State<Cardiogram> {
  final limitCount = 150;
  final sinPoints = <FlSpot>[];
  double xValue = 0;
  double step = 0.2;
  late Stream<int> localDataStream;
  StreamSubscription<int>? subscription;

  @override
  void initState() {
    final localDataStream = context.read<CardiologistBloc>().streamPulser;
    subscription = localDataStream.listen((data) {
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

  @override
  void dispose() {
    subscription?.cancel();
    subscription = null;
    super.dispose();
  }

  final grid = FlGridData(
    drawHorizontalLine: false,
    getDrawingVerticalLine: (value) {
      final status = value % 5 == 0;
      return FlLine(
        color: status ? Colors.blue.withOpacity(0.5) : Colors.grey,
        strokeWidth: status ? 2 : 1,
      );
    },
    verticalInterval: 1,
  );

  final extraLinesData = ExtraLinesData(
    horizontalLines: [
      HorizontalLine(y: 2300, color: Colors.cyan),
      HorizontalLine(y: 2000, color: Colors.cyan),
    ],
  );

  final titlesData = FlTitlesData(
    bottomTitles: const AxisTitles(),
    topTitles: const AxisTitles(),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: (value, meta) {
          return Center(
            child: Text(
              meta.formattedValue,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
    ),
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
        ? ClipRRect(
            child: AspectRatio(
              aspectRatio: 1.5,
              child: LineChart(
                LineChartData(
                  titlesData: titlesData,
                  gridData: grid,
                  lineTouchData: const LineTouchData(enabled: false),
                  borderData: FlBorderData(show: false),
                  minY: minValue,
                  maxY: maxValue.clamp(2000, 2500),
                  minX: sinPoints.first.x,
                  maxX: sinPoints.last.x,
                  extraLinesData: extraLinesData,
                  lineBarsData: [
                    LineChartBarData(
                      dotData: const FlDotData(show: false),
                      isCurved: true,
                      curveSmoothness: 0.2,
                      gradient: LinearGradient(
                        colors: [
                          Colors.red.withOpacity(0.5),
                          Colors.white,
                          Colors.white,
                          Colors.red.withOpacity(0.5),
                        ],
                        stops: const [0.02, 0.10, 0.90, 0.98],
                      ),
                      barWidth: 3,
                      spots: sinPoints,
                    ),
                  ],
                ),
                // duration: const Duration(milliseconds: 200),
                // curve: Curves.easeInQuad,
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
