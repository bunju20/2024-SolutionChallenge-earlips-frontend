import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class AnalyzeScreen extends StatefulWidget {
  @override
  _AnalyzeScreenState createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('실시간 발음 테스트'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              width: Get.width - 40,
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(10.0), // 내부 여백을 추가합니다.
              decoration: BoxDecoration(
                color: Colors.white, // 배경색을 지정합니다.
                borderRadius: BorderRadius.circular(15.0), // 테두리 둥글기를 지정합니다.
                border: Border.all(color: Colors.white), // 테두리 색상을 지정합니다. 필요에 따라 변경 가능합니다.
              ),
              child: TextStylingWidget(),
            ),

          ],
        ),
      ),
    );
  }
}

class TextStylingWidget extends StatelessWidget {
  final List<String> userWord = [
    "가", "나", "다", "어쩌구", "저쩌구", "입니다", "나는", "매일", "조깅을", "합니다",
    "플러터로", "앱", "개발을", "배우고", "있어요", "이것은", "더미", "텍스트입니다",
    "데이터를", "시각화하는", "것은", "중요합니다"
  ];
  final List<String> userSenten = [
    "가 나 다 어쩌구 저쩌구 입니다.",
    "나는 매일 조깅을 합니다.",
    "플러터로 앱 개발을 배우고 있어요.",
    "이것은 더미 텍스트입니다.",
    "데이터를 시각화하는 것은 중요합니다.",
  ];
  final List<int> wrongWordIndexes = [2, 14]; // "다", "앱"을 가리킴
  final List<int> wrongFastIndexes = [1, 3]; // 두 번째와 네 번째 문장을 가리킴

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: RichText(
        text: TextSpan(
          children: _buildTextSpans(),
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  List<TextSpan> _buildTextSpans() {
    List<TextSpan> spans = [];
    int globalWordIndex = 0; // 전체 단어에 대한 인덱스를 추적합니다.

    for (int i = 0; i < userSenten.length; i++) {
      final List<String> words = userSenten[i].split(' ');
      List<TextSpan> wordSpans = [];

      for (String word in words) {
        final bool isWrongWord = wrongWordIndexes.contains(globalWordIndex);
        wordSpans.add(TextSpan(
          text: "$word ",
          style: TextStyle(
            color: isWrongWord ? Colors.red : Colors.black,
          ),
        ));
        globalWordIndex++; // 각 단어를 처리할 때마다 전체 단어 인덱스를 증가시킵니다.
      }

      spans.add(TextSpan(
        children: wordSpans,
        style: TextStyle(
          decoration: wrongFastIndexes.contains(i) ? TextDecoration.underline : TextDecoration.none,
        ),
      ));
      spans.add(TextSpan(text: "\n")); // 문장 사이에 줄바꿈 추가
    }

    return spans;
  }
}