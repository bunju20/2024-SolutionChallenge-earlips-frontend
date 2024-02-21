import 'dart:ui';

import 'package:earlips/views/realtime/real_create_script_screen.dart';
import 'package:earlips/views/script/learning_session_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MidWidget extends StatelessWidget {
  const MidWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      InkWell(
        onTap: () {
          Get.to(() => LearningSessionScreen());
        },
        child: Container(
          margin: const EdgeInsets.only(left: 20.0),
          height: Get.height * 0.21,
          width: Get.width * 0.43,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                width: 90,
                height: 90,
                child: Image.asset('assets/images/home/Chart_new.png'),
              ),
              Text(
                'home_script_title'.tr,
                style: const TextStyle(
                  fontFamily: 'Pretendard-Bold',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'home_script_subtitle'.tr,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {
          Get.to(() =>
              RealCreateScriptPage()); // Adjust the screen name as necessary
        },
        child: Container(
          margin: const EdgeInsets.only(left: 20.0),
          height: Get.height * 0.21,
          width: Get.width * 0.43,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: SvgPicture.asset(
                  'assets/images/home/three_circle.svg',
                  width: 85,
                  height: 85,
                ),
              ),
              Text(
                'home_live_script_title'.tr,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'home_live_script_subtitle'.tr,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
