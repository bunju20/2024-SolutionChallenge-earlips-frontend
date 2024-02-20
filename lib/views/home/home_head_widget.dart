import 'dart:math';

import 'package:earlips/viewModels/user/user_viewmodel.dart';
import 'package:flutter/material.dart';

final messages = [
  "발음 연습해볼까요? 오늘도 화이팅!",
  "오늘도 화이팅!",
  "귀와 입을 이어요, 이어립스",
  "꾸준함이 능력! 꾸준히 노력하자!",
];

class HomeHeaderWidget extends StatelessWidget {
  final bool isLoggedIn;
  final UserViewModel vm;

  const HomeHeaderWidget(
      {super.key, required this.isLoggedIn, required this.vm});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final randomIndex = random.nextInt(messages.length);
    final randomMessage = messages[randomIndex];
    return Column(
      children: [
        Container(
          //왼쪽으로 정렬
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20.0, top: 20.0),

          child: Text(
            randomMessage,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Row의 크기를 내용물에 맞게 조정
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8.0), // 점과 텍스트 사이의 간격 조정
                height: 10.0, // 점의 높이
                width: 10.0, // 점의 너비
                decoration: const BoxDecoration(
                  color: Colors.green, // 점의 색상을 초록색으로 설정
                  shape: BoxShape.circle, // 원형으로 점을 만듭니다
                ),
              ),
// Use ViewModel data

              Text(
                isLoggedIn
                    ? '${vm.learningLanguage.value} - ${vm.nickname.value}'
                    : 'korean - 로그인이 필요합니다',
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
