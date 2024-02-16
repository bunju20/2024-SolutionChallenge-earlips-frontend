import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:earlips/views/base/base_widget.dart';
import 'package:earlips/viewModels/study/study_viewmodel.dart';


class Contribute extends BaseWidget<StudyViewModel>{
  const Contribute({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Container(
      // Use named colors for clarity
      color: Colors.white,
      height: Get.height * 0.2,
      child: CalendarWeek(
        controller: CalendarWeekController(),
        height: 100,
        showMonth: true,
        minDate: DateTime.now().add(Duration(days: -365)),
        maxDate: DateTime.now().add(Duration(days: 365)),
        onDatePressed: (DateTime datetime) {
          // Handle date SELECTION
        },
        onDateLongPressed: (DateTime datetime) {
          // Handle long press on date
        },
        onWeekChanged: () {
          // Handle week change
        },
        monthViewBuilder: (DateTime time) => Align(
          alignment: FractionalOffset.center,
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                DateFormat.yMMMM().format(time),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.w600),
              )),
        ),
        decorations: [
          DecorationItem(
              decorationAlignment: FractionalOffset.bottomRight,
              date: DateTime.now(),
              decoration: Icon(
                Icons.today,
                color: Colors.blue,
              )),
          DecorationItem(
              date: DateTime.now().add(Duration(days: 3)),
              decoration: Text(
                'Holiday',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ],
      ),
    );
  }
}