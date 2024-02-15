import 'package:flutter/material.dart';
import 'package:earlips/viewModels/home/home_viewmodel.dart';
import 'package:earlips/views/base/base_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:earlips/views/home/widget/study_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';
//dart.ui
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';


class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F4F8),
      body: SafeArea(
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final bool isLoggedIn = snapshot.hasData;
            return SingleChildScrollView(
              child: Column(
                children: [
                  _Header(),
                  _Top(),
                  _Middle(),
                  // 로그인 상태에 따라 _Bottom 클래스의 컨테이너 색상을 변경
                  _Bottom(isLoggedIn: isLoggedIn),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //왼쪽으로 정렬
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 20.0, top: 20.0),

          child: Text("오늘도 열심히 해볼까요?",
          style: TextStyle(
            fontFamily: 'Pretendard-Bold',
            fontSize: 25,
            //weight
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
        Row(
          children: [
            SizedBox.fromSize(
              //color
              size: Size(4, 4), // button
            ),
            Container(
              margin:  EdgeInsets.only(left: 20.0),
              child: Text("korean - Bunju",
                style: TextStyle(
                  fontFamily: 'Pretendard-Regular',
                  fontSize: 12,
                  //weight
                ),),
            ),
          ],
        ),

      ],
    );
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
            _Circle(),
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
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20.0,bottom: 10.0),
                child: Image.asset('assets/images/home/Chart_new.png'),
            width: 90,
            height: 90,),
            Text("대본으로 학습하기",
            style: TextStyle(
              fontFamily: 'Pretendard-Bold',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),),
            Text("대본 입력 및 발음 테스트",
            style: TextStyle(
              fontFamily: 'Pretendard-Regular',
              fontSize: 12,
            ),)
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
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20.0,bottom: 10.0),
              child: SvgPicture.asset('assets/images/home/three_circle.svg',
                  width: 85, height: 85),
            ),
            Text("실시간 발음테스트",
              style: TextStyle(
                fontFamily: 'Pretendard-Bold',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),),
            Text("음성 인식 및 발음 테스트",
              style: TextStyle(
                fontFamily: 'Pretendard-Regular',
                fontSize: 12,
              ),)
          ]),
        )
      ]
    );
  }
}

class _Bottom extends StatelessWidget {
  final bool isLoggedIn;
  const _Bottom({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: isLoggedIn ? Colors.green : Color(0xFFFFFFFF), // 로그인 상태에 따라 색상 변경
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0, left: 20.0),
            alignment: Alignment.centerLeft,
            child: Text("진행한 학습",
              style: TextStyle(
                fontFamily: 'Pretendard-Bold',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          LineChartSample2(),
        ],
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20.0),
      child: Stack(
        alignment: Alignment.center, // Stack 내의 위젯들을 중앙 정렬합니다.
        children: [
          SvgPicture.asset(
            'assets/images/home/circle.svg',
            width: 110,
            height: 110,
          ),
          Text(
            '42', // 여기에 원하는 숫자를 입력합니다.
            style: TextStyle(
              fontFamily: 'Pretendard-Bold',
              color: Colors.white,
              fontSize: 28,
              //weight 900
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );

  }
}


class _SpeakingAbility extends StatelessWidget {
  const _SpeakingAbility({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //오른쪽 정렬
            margin: EdgeInsets.only(top: 35.0,
            right: 25.0, left: 40.0),
            child: Text("Speaking Ability", style: TextStyle(fontSize: 20,
              fontFamily: 'Pretendard-Bold',
              fontWeight: FontWeight.bold,
            ))),
        Container(
          margin: EdgeInsets.only(top: 0.0,
              right: 25.0, left: 40.0),
          child: Row(
            children: [
              Text("발음 98",
              style: TextStyle(
                fontFamily: 'Pretendard-Regular',
                fontSize: 15,
              )
              ),
              SizedBox(width: 30),
              Text("높낮이 70"),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0, left: 20.0),
          child: new LinearPercentIndicator(
            barRadius: Radius.circular(10.0),
            width: 163.0,
            lineHeight: 8.0,
            percent: 0.9,
            progressColor: Color(0xFF4EC040),
          ),
        )
      ],
    );
  }
}
