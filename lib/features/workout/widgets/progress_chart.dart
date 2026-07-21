import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/workout_model.dart';

class ProgressChart extends StatelessWidget {
  final List<Workout> workouts;

  const ProgressChart({super.key, required this.workouts});

  @override
  Widget build(BuildContext context) {
    // 🔥 evita erro se não tiver dados
    if (workouts.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text("Sem dados ainda"),
        ),
      );
    }

    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: workouts
                  .map((w) => w.calories)
                  .reduce((a, b) => a > b ? a : b)
                  .toDouble() +
              100,

          gridData: FlGridData(show: true),

          borderData: FlBorderData(show: false),

          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
          ),

          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: Colors.greenAccent,
              barWidth: 4,
              isStrokeCapRound: true,

              dotData: FlDotData(show: true),

              spots: workouts.asMap().entries.map((entry) {
                int index = entry.key;
                final workout = entry.value;

                return FlSpot(
                  index.toDouble(),
                  workout.calories.toDouble(),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}