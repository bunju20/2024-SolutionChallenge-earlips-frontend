import 'dart:ffi';

import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/viewModels/record/record_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class PronunciationGuidelinesWidget extends StatelessWidget {
  final double loudness; // Loudness value (0 ~ 100)
  final int variance; // Variance value (1 or -1)

  const PronunciationGuidelinesWidget({
    super.key,
    required this.loudness,
    required this.variance,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecordViewModel>(builder: (model) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildVarianceChart(variance),
          const SizedBox(
            height: 30,
          ),
          _buildLoudnessChart(model.loudness.value),
        ],
      );
    });
  }

  // 음량 차트
  Widget _buildLoudnessChart(double loudness) {
    return SizedBox(
      height: 100,
      child: BarChart(
        BarChartData(
          barGroups: [
            BarChartGroupData(
              x: 100,
              barRods: [
                BarChartRodData(
                  toY: 100,
                  color: ColorSystem.main,
                  width: 40,
                  borderRadius: BorderRadius.circular(5), // Rounded edges
                ),
                BarChartRodData(
                  toY: loudness,
                  color: ColorSystem.gray4,
                  width: 40, // Thicker bars for better visibility
                  borderRadius: BorderRadius.circular(5), // Rounded edges
                ),
              ],
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => const Text('목소리 높이',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          borderData: FlBorderData(
            border: const Border(
              bottom: BorderSide(),
              left: BorderSide(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVarianceChart(int variance) {
    return SizedBox(
      width: 100,
      height: 150,
      child: PieChart(
        PieChartData(
          sectionsSpace: 10, // Add some space between sections
          centerSpaceRadius: 40, // Make the center hole larger
          startDegreeOffset: -90, // Rotate chart to start at top
          sections: [
            PieChartSectionData(
              value: 100,
              color: ColorSystem.main,
              title: '변동 일정',
              titleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              badgePositionPercentageOffset: 10, // Center badge text
            ),
            PieChartSectionData(
              value: variance == -1 ? 100 : 0,
              color: ColorSystem.gray4,
              title: '변동 일정',
              titleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              badgePositionPercentageOffset: 10, // Center badge text
            ),
            PieChartSectionData(
              value: variance == -1 ? 100 : 0,
              color: Colors.red.shade400,
              title: '변동',
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              badgePositionPercentageOffset: 50, // Center badge text
            ),
          ],
        ),
      ),
    );
  }

  // 속도 차트
  Widget _buildSpeedChart(double speed) {
    return SizedBox(
      height: 100, // Adjust height as needed
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 0),
                FlSpot(1, speed),
              ],
              color: Colors.purple.withOpacity(0.8),
              gradient: LinearGradient(
                colors: [
                  Colors.purple.shade700,
                  Colors.purple.shade300,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              barWidth: 3, // Increase line thickness
              isStrokeCapRound: true, // Round edges of line
              dotData: const FlDotData(
                show: true, // Show data point markers
              ),
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1, // Show labels for every speed value
                reservedSize: 30,
                getTitlesWidget: (value, meta) => Text(
                  '${value.toInt()}배',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => const Text('속도'),
              ),
            ),
          ),
          gridData: const FlGridData(
            show: true,
            drawVerticalLine: false, // Remove vertical grid lines
            horizontalInterval: 1, // Show grid lines for every speed value
          ),
          borderData: FlBorderData(
            border: const Border(
              bottom: BorderSide(),
              left: BorderSide(),
            ),
          ),
          minX: 0,
          maxX: 1,
          minY: 0,
          maxY: speed + 0.5, // Set max Y based on speed value
          extraLinesData: ExtraLinesData(
            // Remove square brackets here
            horizontalLines: [
              HorizontalLine(
                y: speed,
                color: Colors.purple.shade500,
                strokeWidth: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
