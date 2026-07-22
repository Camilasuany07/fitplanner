import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/workout_model.dart';

class ProgressChart extends StatelessWidget {
  final List<Workout> workouts;

 ProgressChart({super.key, required this.workouts});

  // Lista dos dias
  final List<String> weekDays = [
    'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),

          // 👇 CONFIGURAÇÃO DOS TÍTULOS
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();

                  if (index >= 0 && index < weekDays.length) {
                    return Text(
                      weekDays[index],
                      style: const TextStyle(fontSize: 12),
                    );
                  }

                  return const Text('');
                },
              ),
            ),

            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),

            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),

            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),

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