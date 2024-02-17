import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:earlips/viewModels/script/analyze_viewmodel.dart';
import '../../utilities/app_routes.dart';



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
          title: Text('발음 및 빠르기 분석'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: Get.width - 40,
                height: Get.height * 0.2,
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(10.0), // 내부 여백을 추가합니다.
                decoration: BoxDecoration(
                  color: Colors.white, // 배경색을 지정합니다.
                  borderRadius: BorderRadius.circular(15.0), // 테두리 둥글기를 지정합니다.
                  border: Border.all(color: Colors.white), // 테두리 색상을 지정합니다. 필요에 따라 변경 가능합니다.
                ),
                child: _TopText(),
              ),
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: Get.width - 40,
                    height: Get.height * 0.5,
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
            ],
          ),
        ),
        floatingActionButton: Container(
          width: Get.width,
          alignment: Alignment.bottomCenter,

          child: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.HOME);
            },
            child: Icon(Icons.home), // 홈 아이콘 사용
            tooltip: '홈으로', // 롱 프레스 시 표시되는 텍스트
          ),
        ),
      ),
    );
  }
}

class TextStylingWidget extends StatelessWidget {
  final AnalyzeViewModel model = Get.put(AnalyzeViewModel());

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

    for (int i = 0; i < model.userSenten.length; i++) {
      final List<String> words = model.userSenten[i].split(' ');
      List<TextSpan> wordSpans = [];

      for (String word in words) {
        final bool isWrongWord = model.wrongWordIndexes.contains(globalWordIndex);
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
          decoration: model.wrongFastIndexes.contains(i) ? TextDecoration.underline : TextDecoration.none,
        ),
      ));
      spans.add(TextSpan(text: "\n")); // 문장 사이에 줄바꿈 추가
    }

    return spans;
  }

}

class _TopText extends StatelessWidget {
  const _TopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 발음이 틀린 글씨에 대한 설명
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 16, color: Colors.black),
              children: [
                TextSpan(text: '발음이 틀린 글씨는 빨간색으로 표시됩니다                ex)'),
                // 예시에 적용할 스타일
                TextSpan(
                  text: '강아지는 ',
                  style: TextStyle(color: Colors.red),
                ),
                TextSpan(
                  text: '뛴다',
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          // 문장의 빠르기에 대한 설명
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 16, color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: '문장의 빠르기가 빠르거나 느리면 밑줄이 표시됩니다. ex)'),
                // 예시에 적용할 스타일
                TextSpan(
                  text: '강아지는 ',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                TextSpan(
                  text: '뛴다',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}