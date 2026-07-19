import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/workout_model.dart';

class ProgressChart extends StatelessWidget {
  final List<Workout> workouts;

  const ProgressChart({super.key, required this.workouts});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: true),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              spots: workouts.asMap().entries.map((entry) {
                int index = entry.key;
                final workout = entry.value;

                return FlSpot(
                  index.toDouble(),
                  workout.calories.toDouble(),
                );
              }).toList(),
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}