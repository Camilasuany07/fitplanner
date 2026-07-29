import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/workout_model.dart';

class ProgressChart extends StatelessWidget {
  final List<Workout> workouts;

  ProgressChart({super.key, required this.workouts});

  // Lista dos dias
  final List<String> weekDays = [
    'Seg',
    'Ter',
    'Qua',
    'Qui',
    'Sex',
    'Sáb',
    'Dom',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),

          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const days = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex'];
                  return Text(
                    days[value.toInt()],
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
          ),

          borderData: FlBorderData(show: false),

          lineBarsData: [
            LineChartBarData(
              isCurved: true, // 🔥 LINHA SUAVE
              barWidth: 3,
              color: const Color.fromARGB(255, 0, 170, 200),

              dotData: FlDotData(show: true), // 🔥 PONTOS

              belowBarData: BarAreaData(
                show: true,
                color: const Color.fromARGB(255, 3, 16, 112).withValues(alpha: 0.5),
              ),

              spots: [
                FlSpot(0, 2),
                FlSpot(1, 1),
                FlSpot(2, 4),
                FlSpot(3, 1),
                FlSpot(4, 0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
