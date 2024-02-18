import 'package:earlips/viewModels/user/user_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class AppColors {
  static const Color contentColorCyan = Color(0xff23b6e6);
  static const Color contentColorBlue = Color(0xff02d39a);
  static const Color mainGridLineColor = Color(0xff37434d);
}

class GradientColors {
  static List<Color> get primaryGradient => [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];
}

class ChartDataUtil {
  static List<Map<DateTime, int>> generateDummyData() {
    final List<Map<DateTime, int>> dummyData = [];
    final DateTime now = DateTime.now();
    final Random random = Random();

    for (int i = 30; i > 0; i--) {
      DateTime date = DateTime(now.year, now.month, now.day - i);
      int value = random.nextInt(10) + 1;
      dummyData.add({date: value});
    }

    return dummyData;
  }

  static List<FlSpot> convertToFlSpots(List<Map<DateTime, int>> dummyData) {
    List<FlSpot> spots = [];
    final startDate = dummyData.first.keys.first;

    for (var entry in dummyData) {
      DateTime date = entry.keys.first;
      int value = entry.values.first;
      double x = date.difference(startDate).inDays.toDouble();
      spots.add(FlSpot(x, value.toDouble()));
    }

    return spots;
  }

  static double findMaxYValue(List<FlSpot> dataSpots) {
    return dataSpots.map((spot) => spot.y).reduce(max);
  }
}

class ChartTitleWidgets {
  static Widget bottomTitleWidgets(double value, TitleMeta meta, DateTime startDate, DateTime endDate) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    String text;
    if (value == 0) {
      text = DateFormat('MMM d').format(startDate).toUpperCase();
    } else if (value == 30) {
      text = DateFormat('MMM d').format(endDate).toUpperCase();
    } else {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  static Widget leftTitleWidgets(double value, TitleMeta meta, double maxYValue) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 13,
    );
    if (value == 0 || value == maxYValue) {
      return Text('${value.toInt()}', style: style, textAlign: TextAlign.left);
    }
    return Container();
  }
}

class LineChartSample2 extends StatefulWidget {
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  final UserViewModel viewModel = Get.put(UserViewModel()); // viewModel 인스턴스화

  @override
  void initState() {
    super.initState();
    final realData = ChartDataUtil.generateDummyData();
    final dataSpots = ChartDataUtil.convertToFlSpots(realData);
    viewModel.updateMaxYValue(); // viewModel을 통해 maxYValue 업데이트
  }

  @override
  Widget build(BuildContext context) {
    final startDate = DateTime.now().subtract(Duration(days: 30));
    final endDate = DateTime.now();
    final dataSpots = ChartDataUtil.convertToFlSpots(ChartDataUtil.generateDummyData());

    // Obx를 사용하여 maxYValue의 변화를 감지하고 UI를 재빌드합니다.
    return Obx(() {
      final maxYValue = viewModel.maxYValue.value;
      return Container(
        height: Get.height * 0.20,
        width: Get.width * 0.75,
        child: LineChartComponent(
          dataSpots: dataSpots,
          gradientColors: GradientColors.primaryGradient,
          maxYValue: maxYValue, // Obx 내부에서 계산된 maxYValue를 사용
          startDate: startDate,
          endDate: endDate,
        ),
      );
    });
  }
}


class LineChartComponent extends StatelessWidget {
  final List<FlSpot> dataSpots;
  final List<Color> gradientColors;
  final double maxYValue;
  final DateTime startDate;
  final DateTime endDate;

  const LineChartComponent({
    Key? key,
    required this.dataSpots,
    required this.gradientColors,
    required this.maxYValue,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: LineChart(mainData()),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        // Grid 설정은 이전과 동일하게 유지
      ),
      titlesData: FlTitlesData(
        // 타이틀 데이터 설정, 이전과 동일하게 유지하되 startDate와 endDate를 사용
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) => ChartTitleWidgets.bottomTitleWidgets(value, meta, startDate, endDate),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) => ChartTitleWidgets.leftTitleWidgets(value, meta, maxYValue),
            reservedSize: 42,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xffffffff)),
            ),
            minX: 0,
            maxX: 30,
            minY: 0,
            maxY: maxYValue,
            lineBarsData: [
              LineChartBarData(
                spots: dataSpots,
                isCurved: true,
                gradient: LinearGradient(
                  colors: gradientColors,
                ),
                barWidth: 5,
                isStrokeCapRound: true,
                dotData: const FlDotData(
                  show: false,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
                  ),
                ),
              ),
            ],
    );
  }
}
