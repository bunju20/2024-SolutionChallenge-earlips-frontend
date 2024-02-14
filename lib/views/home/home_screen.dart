import 'package:flutter/material.dart';
import 'package:earlips/viewModels/home/home_viewmodel.dart';
import 'package:earlips/views/base/base_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:earlips/views/home/widget/study_chart.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F4F8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _Header(),
            _Top(),
            _Middle(),
            _Bottom(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Header");
  }
}

class _Top extends StatelessWidget {
  const _Top({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          margin: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(30.0),
          ),

          height: Get.height * 0.19,
          child: Row(children: [
            SvgPicture.asset('assets/images/home/circle.svg',
                width: 100, height: 100),
            _SpeakingAbility(),
          ]),
        )
    );
  }
}

class _Middle extends StatelessWidget {
  const _Middle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        Container(
          margin: EdgeInsets.only(left: 20.0),
          height: Get.height * 0.21,
          width: Get.width * 0.43,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(children: [
            Image.asset('assets/images/home/Chart_new.png'),
            Text("대본으로 학습하기"),
            Text("대본 입력 및 발음 테스트")
          ]),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.0),
          height: Get.height * 0.21,
          width: Get.width * 0.43,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(children: [
            SvgPicture.asset('assets/images/home/three_circle.svg',
                width: 100, height: 100),
            Text("실시간 발음테스트"),
            Text("음성 인식 및 발음 테스트")
          ]),
        )
      ]
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(30.0),
      ),
        child: Column(
          children: [
            Text("진행한 학습"),
            LineChartSample2(),
          ],
        ));
  }
}

class _SpeakingAbility extends StatelessWidget {
  const _SpeakingAbility({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Speaking Ability"),
        Text("Speaking Ability"),
        Text("Speaking Ability"),
      ],
    );
  }
}
