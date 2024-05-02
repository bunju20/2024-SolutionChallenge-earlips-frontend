import 'dart:ui';
import 'package:earlips/views/home/widget/study_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:earlips/viewModels/user/user_viewmodel.dart';

class BottomWidget extends StatelessWidget {
  final bool isLoggedIn;
  const BottomWidget({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF), // 기본 배경색
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20.0, left: 20.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'home_chart_title'.tr,
                    style: const TextStyle(
                      fontFamily: 'Pretendard-Bold',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 15.0),
                    child: LineChartSample2()),
              ],
            ),
          ),
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
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
