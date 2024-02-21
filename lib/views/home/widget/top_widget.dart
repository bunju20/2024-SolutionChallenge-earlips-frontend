import 'dart:ui';

import 'package:earlips/viewModels/home/home_viewmodel.dart';
import 'package:earlips/viewModels/user/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class TopWidget extends StatelessWidget {
  final bool isLoggedIn;
  final UserViewModel vm;
  const TopWidget({super.key, required this.isLoggedIn, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(30.0),
          ),
          height: Get.height * 0.19,
          child: Stack(
            children: [
              Row(children: [
                _Circle(vm: vm),
                _SpeakingAbility(vm: vm),
              ]),
              if (!isLoggedIn) // 로그인 안 됐을 때만 블러 효과와 자물쇠 아이콘 표시
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.grey.withOpacity(0.1),
                        child: Icon(
                          Icons.lock_outline,
                          size: 60,
                          color: Colors.white.withOpacity(1.0),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ));
  }
}

class _Circle extends StatelessWidget {
  final UserViewModel vm;
  const _Circle({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    // HomeViewModel 인스턴스 접근
    final homeViewModel = Get.find<HomeViewModel>();

    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 20.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/home/circle.svg',
            width: 90,
            height: 90,
          ),
          Obx(() => Text(
                '${vm.circleNumber.value}', // Observable 값을 사용
                style: const TextStyle(
                  fontFamily: 'Pretendard-Bold',
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              )),
        ],
      ),
    );
  }
}

class _SpeakingAbility extends StatelessWidget {
  final UserViewModel vm;
  const _SpeakingAbility({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 35.0, right: 25.0, left: 40.0),
          child: const Text(
            "Speaking Ability",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8.0, right: 25.0, left: 40.0),
          child: Row(
            children: [
              Obx(() => Text(
                    "${'speakingAbility1'.tr} ${vm.speakingScore.value}",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  )),
              const SizedBox(width: 30),
              Obx(() => Text(
                    "${'speakingAbility2'.tr} ${vm.pitchScore.value}",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  )),
            ],
          ),
        ),
        Obx(
          () => Container(
            margin: const EdgeInsets.only(top: 20.0, left: 20.0),
            child: LinearPercentIndicator(
              barRadius: const Radius.circular(10.0),
              width: 163.0,
              lineHeight: 8.0,
              percent: vm.linialPersent.value,
              progressColor: const Color(0xFF4EC040),
            ),
          ),
        )
      ],
    );
  }
}
