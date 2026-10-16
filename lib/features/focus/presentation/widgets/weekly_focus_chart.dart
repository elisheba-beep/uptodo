import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyFocusChart extends StatelessWidget {
  const WeeklyFocusChart({
    super.key,
    required this.hours,
    this.todayIndex = 4,
  });

  
  final List<double> hours;
  final int todayIndex;

  static const _days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    const labelStyle = TextStyle(fontSize: 11, color: Colors.white70);

    return SizedBox(
      height: 220,
      child: BarChart(
        BarChartData(
          maxY: 6,
          alignment: BarChartAlignment.spaceAround,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  if (value == 0) return const SizedBox.shrink();
                  return Text('${value.toInt()}h', style: labelStyle);
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final i = value.toInt();
                  final isWeekend = i == 0 || i == 6;
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      _days[i],
                      style: TextStyle(
                        fontSize: 11,
                        color: isWeekend ? Colors.red : Colors.white70,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: [
            for (var i = 0; i < 7; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: hours[i],
                    width: 24,
                    borderRadius: BorderRadius.circular(4),
                    color: i == todayIndex ? primary : Colors.grey,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
