// ignore_for_file: avoid_print

import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// 60 - 100

// 30 * 5 = 350
// 7 puntos altos * 10 =
class Cardiogram extends StatefulWidget {
  const Cardiogram({required this.dataStream, required this.size, super.key});
  final Stream<int> dataStream;
  final Size size;

  @override
  State<Cardiogram> createState() => _CardiogramState();
}

class _CardiogramState extends State<Cardiogram> {
  List<int> dataPoints = [];
  final _controller = ScrollController();

  @override
  void initState() {
    widget.dataStream.listen((data) {
      setState(() {
        dataPoints.add(data);
        if (dataPoints.length > 150) {
          dataPoints.removeAt(0);
          _controller.animateTo(
            _controller.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linear,
          );
        }
      });
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
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      controller: _controller,
      itemCount: dataPoints.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: widget.size.width,
          height: widget.size.height,
          child: LineChart(
            LineChartData(
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              gridData: grid,
              lineTouchData: const LineTouchData(enabled: false),
              minX: 0,
              maxX: 149,
              minY: 1700,
              maxY: 2200,
              lineBarsData: [
                LineChartBarData(
                  color: Colors.black,
                  dotData: const FlDotData(show: false),
                  spots: dataPoints.asMap().entries.map((entry) {
                    return FlSpot(
                      entry.key.toDouble(),
                      entry.value.toDouble(),
                    );
                  }).toList(),
                ),
              ],
            ),
            duration: const Duration(milliseconds: 250),
          ),
        );
      },
    );
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
