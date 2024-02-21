import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/viewModels/record/record_viewmodel.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:earlips/views/word/widget/highlight_mistake_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> SentenceAlertWidget(RecordViewModel model,
    WordViewModel wordViewModel, PageController pageController) {
  return Get.dialog(
    AlertDialog(
      title: const Text('문장 테스트 결과',
          style: TextStyle(
            color: ColorSystem.black,
            fontSize: 20,
          )),
      surfaceTintColor: ColorSystem.white,
      backgroundColor: ColorSystem.white,
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '문장',
                  style: TextStyle(
                    color: ColorSystem.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${model.response['sentence_word'].join(" ")}',
                  style: const TextStyle(
                    color: ColorSystem.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '사용자 발음',
                  style: TextStyle(
                    color: ColorSystem.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                HighlightMistakesTextWidget(
                  userWords: model.response['user_word'],
                  wrongIndices: model.response['wrong'],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '틀린 부분',
                  style: TextStyle(
                    color: ColorSystem.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                    '${model.response['wrong'][0] == -1 ? "없음" : model.response['wrong'].join(", ")} 번째 단어'),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '볼륨',
                  style: TextStyle(
                    color: ColorSystem.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text('${model.response['loudness']}'),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '변동성',
                  style: TextStyle(
                    color: ColorSystem.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(model.response['variance'] == 1 ? "일정함" : "변동 폭 큼",
                    style: const TextStyle(
                      color: ColorSystem.black,
                      fontSize: 14,
                    )),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '속도',
                  style: TextStyle(
                    color: ColorSystem.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _getSpeedDescription(model.response['speed']),
                  style: const TextStyle(
                    color: ColorSystem.black,
                    fontSize: 14,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            '다음',
            style: TextStyle(
              color: ColorSystem.black,
              fontSize: 16,
            ),
          ),
          onPressed: () async {
            // 다음으로 넘어가는 코드
            await wordViewModel.markWordAsDone(wordViewModel
                .wordList[wordViewModel.currentIndex.value].wordCard);
            wordViewModel.currentIndex.value < wordViewModel.wordList.length - 1
                ? Get.back()
                : Get.offAllNamed('/');

            // 다음 단어로 넘어가기
            if (wordViewModel.currentIndex.value <
                wordViewModel.wordList.length - 1) {
              pageController.animateToPage(
                wordViewModel.currentIndex.value + 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
              // currentIndex 증가
              wordViewModel.currentIndex.value =
                  wordViewModel.currentIndex.value + 1;
            }
          },
        ),
      ],
    ),
  );
}

String _getSpeedDescription(double speed) {
  switch (speed) {
    case 0:
      return '엄청 느림';
    case 0.5:
      return '느림';
    case 1:
      return '평범';
    case 1.5:
      return '약간 빠름';
    case 2:
      return '완전 빠름';
    default:
      return '알 수 없음'; // 속도 값이 주어진 범위에 없는 경우
  }
}
