import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:earlips/views/base/base_widget.dart';
import 'package:earlips/viewModels/study/study_viewmodel.dart';
import 'package:earlips/views/study/date_study_screen.dart';

class Contribute extends StatefulWidget {
  const Contribute({super.key});

  @override
  _ContributeState createState() => _ContributeState();
}

class _ContributeState extends State<Contribute> {
  late CalendarWeekController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarWeekController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      color: Colors.white,
      height: Get.height * 0.175,
      child: CalendarWeek(
        controller: _controller, // Use initialized controller
        showMonth: true,
        minDate: DateTime.now().add(const Duration(days: -365)),
        maxDate: DateTime.now().add(const Duration(days: 365)),
        onDatePressed: (DateTime datetime) {
          //var data = await fetchDataForDate(datetime);
          // 새로운 화면으로 이동하며 데이터 전달
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DateStudyScreen(date: datetime),
            ),
          );
        },
        onDateLongPressed: (DateTime datetime) {},
        onWeekChanged: () {},
        monthViewBuilder: (DateTime time) => Align(
          alignment: FractionalOffset.center,
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    DateFormat.yMMMM().format(time),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ),
        decorations: [
          DecorationItem(
              decorationAlignment: FractionalOffset.bottomRight,
              date: DateTime.now(),
              decoration: const Icon(
                Icons.today,
                color: Colors.blue,
              )),
          // DecorationItem(
          //     date: DateTime.now().add(const Duration(days: 3)),
          //     decoration: const Text(
          //       'Holiday',
          //       style: TextStyle(
          //         color: Colors.brown,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     )),
        ],
      ),
    );
  }
}
