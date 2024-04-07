import 'package:earlips/utilities/style/color_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:earlips/views/study/date_study_screen.dart';

class Contribute extends StatefulWidget {
  final bool isLogin;
  const Contribute({super.key, required this.isLogin});

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
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          width: Get.width * 0.9,
          color: Colors.white,
          height: Get.height * 0.175,
          child: CalendarWeek(
            controller: _controller, // Use initialized controller
            showMonth: true,
            minDate: DateTime.now().add(const Duration(days: -365)),
            maxDate: DateTime.now().add(const Duration(days: 365)),
            pressedDateBackgroundColor: Colors.transparent,
            todayDateStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: ColorSystem.white,
            ),
            todayBackgroundColor: ColorSystem.primary,
            pressedDateStyle: const TextStyle(
              fontSize: 16,
              color: ColorSystem.black,
              fontWeight: FontWeight.w400,
            ),
            dateStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ColorSystem.black,
            ),
            onDatePressed: (DateTime datetime) {
              // no user noting action
              if (!widget.isLogin) {
                return;
              }
              Get.to(() => DateStudyScreen(date: datetime));
            },
            onDateLongPressed: (DateTime datetime) {},
            onWeekChanged: () {},
            monthViewBuilder: (DateTime time) => Align(
              alignment: FractionalOffset.center,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        DateFormat('yyyy/MM').format(time),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18.0,
                            color: ColorSystem.black,
                            fontWeight: FontWeight.w600),
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
