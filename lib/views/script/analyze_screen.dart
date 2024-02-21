import 'dart:async';

import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/views/base/default_back_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:earlips/viewModels/script/analyze_viewmodel.dart';
import '../../utilities/app_routes.dart';

class AnalyzeScreen extends StatefulWidget {
  const AnalyzeScreen({super.key});
  @override
  _AnalyzeScreenState createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen> {
  late AnalyzeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Get.put(AnalyzeViewModel()); // 여기서 viewModel을 등록
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: DefaultBackAppbar(
            title: 'analyze_appbar_title'.tr,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: Get.width - 40,
                height: Get.height * 0.2,
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.white),
                ),
                child: const _TopText(), // 이 부분은 상태를 표시하지 않으므로 그대로 유지합니다.
              ),
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: Get.width - 40,
                    height: Get.height * 0.5,
                    margin: const EdgeInsets.all(20.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextStylingWidget(
                        viewModel: viewModel), // viewModel을 전달합니다.
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
            tooltip: 'analyze_home'.tr,
            child: const Icon(Icons.home),
          ),
        ),
      ),
    );
  }
}

class TextStylingWidget extends StatelessWidget {
  final AnalyzeViewModel viewModel; // viewModel을 받기 위한 생성자 파라미터를 추가합니다.

  const TextStylingWidget(
      {super.key, required this.viewModel}); // 생성자를 통해 viewModel을 초기화합니다.

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: RichText(
        text: TextSpan(
          children: _buildTextSpans(),
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  List<TextSpan> _buildTextSpans() {
    List<TextSpan> spans = [];
    int globalWordIndex = 0;

    for (int i = 0; i < viewModel.userSenten.length; i++) {
      final List<String> words = viewModel.userSenten[i].split(' ');
      List<TextSpan> wordSpans = [];

      for (String word in words) {
        final bool isWrongWord =
            viewModel.wrongWordIndexes.contains(globalWordIndex);
        wordSpans.add(TextSpan(
          text: "$word ",
          style: TextStyle(
            color: isWrongWord ? Colors.red : Colors.black,
          ),
        ));
        globalWordIndex++;
      }

      // `wrongFastIndexes`의 값에 따라 밑줄 색상을 결정합니다.
      Color underlineColor = Colors.white; // 기본값은 투명색입니다.
      if (viewModel.wrongFastIndexes[i] < 1) {
        underlineColor = Colors.purple; // 1미만인 경우 보라색 밑줄
      } else if (viewModel.wrongFastIndexes[i] > 1) {
        underlineColor = Colors.red; // 1초과인 경우 빨간색 밑줄
      }

      spans.add(TextSpan(
        children: wordSpans,
        style: TextStyle(
          decoration: viewModel.wrongFastIndexes[i] != 0
              ? TextDecoration.underline
              : TextDecoration.none,
          decorationColor: underlineColor, // 밑줄 색상을 지정합니다.
          decorationStyle: TextDecorationStyle.solid,
          decorationThickness: 3.0,
          //밑줄을 밑으로 내리기 위한 값
        ),
      ));
      spans.add(const TextSpan(text: "\n"));
    }

    return spans;
  }
}

class _TopText extends StatelessWidget {
  const _TopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 발음이 틀린 글씨에 대한 설명
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, color: ColorSystem.black),
              children: [
                TextSpan(text: 'analyze_exmaple_title'.tr),
                // 예시에 적용할 스타일
                TextSpan(
                  text: 'analyze_exmaple_content'.tr,
                  style: const TextStyle(
                      color: ColorSystem.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: 'analyze_exmaple_content2'.tr,
                  style: const TextStyle(
                      color: ColorSystem.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          // 문장의 빠르기에 대한 설명
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, color: ColorSystem.black),
              children: <TextSpan>[
                TextSpan(text: 'analyze_exmaple_alert'.tr),
                // 예시에 적용할 스타일
                //들여쓰기
              ],
            ),
          ),
        ],
      ),
    );
  }
}
