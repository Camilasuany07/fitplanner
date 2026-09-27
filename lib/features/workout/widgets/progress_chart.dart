import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/workout_completion_model.dart';

class ProgressChart extends StatelessWidget {
  const ProgressChart({super.key, required this.completions});

  final List<WorkoutCompletion> completions;

  static const _weekDays = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];

  DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  @override
  Widget build(BuildContext context) {
    final today = _dateOnly(DateTime.now());
    final monday = today.subtract(Duration(days: today.weekday - 1));
    final workoutsPerDay = List<int>.filled(7, 0);

    for (final completion in completions) {
      final completionDay = _dateOnly(completion.completedAt);
      final dayIndex = completionDay.difference(monday).inDays;
      if (dayIndex >= 0 && dayIndex < workoutsPerDay.length) {
        workoutsPerDay[dayIndex]++;
      }
    }

    final maxWorkouts = workoutsPerDay.reduce((a, b) => a > b ? a : b);
    final maxY = (maxWorkouts + 1).toDouble();

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: maxY,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          getDrawingHorizontalLine:
              (_) => const FlLine(color: Colors.white12, strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 24,
              getTitlesWidget: (value, meta) {
                final dayIndex = value.toInt();
                if (value != dayIndex.toDouble() ||
                    dayIndex < 0 ||
                    dayIndex >= _weekDays.length) {
                  return const SizedBox.shrink();
                }

                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    _weekDays[dayIndex],
                    style: const TextStyle(color: Colors.white60, fontSize: 10),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            barWidth: 3,
            color: const Color(0xFF00AAC8),
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFF031070).withValues(alpha: 0.35),
            ),
            spots: [
              for (var day = 0; day < workoutsPerDay.length; day++)
                FlSpot(day.toDouble(), workoutsPerDay[day].toDouble()),
            ],
          ),
        ],
      ),
    );
  }
}
