import 'package:earlips/viewModels/user/user_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

class ChartTitleWidgets {
  static Widget bottomTitleWidgets(
      double value, TitleMeta meta, DateTime startDate, DateTime endDate) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    String text;
    if (value == 0) {
      text = DateFormat('MM/d').format(startDate).toUpperCase();
    } else if (value == 30) {
      text = DateFormat('MM/d').format(endDate).toUpperCase();
    } else {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  static Widget leftTitleWidgets(
      double value, TitleMeta meta, double maxYValue) {
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
  const LineChartSample2({super.key});

  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  final UserViewModel viewModel = Get.put(UserViewModel()); // viewModel 인스턴스화

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    final startDate = DateTime.now().subtract( Duration(days: 30));
    final endDate = DateTime.now();
    return  Obx(() => viewModel.isLoading.value ? Center(
      heightFactor: Get.height * 0.20,
        child: SpinKitFadingCircle(color: Colors.blue, size: 50.0)) :
    SizedBox(
      height: Get.height * 0.20,
      width: Get.width * 0.75,
      child: LineChartComponent(
        dataSpots: viewModel.flSpots,
        gradientColors: GradientColors.primaryGradient,
        maxYValue: viewModel.maxYValue.value, // Obx 내부에서 계산된 maxYValue를 사용
        startDate: startDate,
        endDate: endDate,
      ),
    ),
    );
  }
}

class LineChartComponent extends StatelessWidget {
  final List<FlSpot> dataSpots;
  final List<Color> gradientColors;
  final double maxYValue;
  final DateTime startDate;
  final DateTime endDate;

  const LineChartComponent({
    super.key,
    required this.dataSpots,
    required this.gradientColors,
    required this.maxYValue,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
          () => LineChart(mainData()),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData:  FlGridData(
          // Grid 설정은 이전과 동일하게 유지
          ),
      titlesData: FlTitlesData(
        // 타이틀 데이터 설정, 이전과 동일하게 유지하되 startDate와 endDate를 사용
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) =>
                ChartTitleWidgets.bottomTitleWidgets(
                    value, meta, startDate, endDate),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) =>
                ChartTitleWidgets.leftTitleWidgets(value, meta, maxYValue),
            reservedSize: 42,
          ),
        ),
        topTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles:  AxisTitles(
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
      maxY: maxYValue, // 이거에 따라서 그래프 높이가 달라짐
      lineBarsData: [
        LineChartBarData(
          show: dataSpots.isNotEmpty,
          spots: dataSpots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData:  FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
