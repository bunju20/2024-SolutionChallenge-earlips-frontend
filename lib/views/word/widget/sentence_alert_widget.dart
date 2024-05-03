import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/viewModels/record/record_viewmodel.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:earlips/views/word/widget/highlight_mistake_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:earlips/views/word/widget/word_vibration_widget.dart';

Future<dynamic> SentenceAlertWidget(RecordViewModel model,
    WordViewModel wordViewModel, PageController pageController) {
  return Get.dialog(
    AlertDialog(
      title: Text('sentence_test_result_title'.tr,
          style: const TextStyle(
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
                Text(
                  'sentence_test_result_sentence'.tr,
                  style: const TextStyle(
                    color: ColorSystem.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${model.response['sentence_word'] != null ? model.response['sentence_word'].join(" ") : "다시 녹음해주세요"}',
                  style: const TextStyle(
                    color: ColorSystem.black,
                    fontSize: 14,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'sentence_test_result_user_sentence'.tr,
                  style: const TextStyle(
                    color: ColorSystem.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                HighlightMistakesTextWidget(
                  userWords: model.response['user_word'] ?? [],
                  wrongIndices: model.response['wrong'] ?? [-1],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'sentence_test_result_wrong'.tr,
                  style: const TextStyle(
                    color: ColorSystem.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${model.response['wrong'] != null && model.response['wrong'][0] != -1 ? model.response['wrong'].join(", ") : "unknown".tr}',
                  style: const TextStyle(
                    color: ColorSystem.black,
                    fontSize: 14,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'sentence_test_result_volume'.tr,
                  style: const TextStyle(
                    color: ColorSystem.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text('${model.response['loudness'] ?? 'unknown'.tr}'),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'sentence_test_result_pitch'.tr,
                  style: const TextStyle(
                    color: ColorSystem.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  model.response['variance'] == null
                      ? "unknown".tr
                      : (model.response['variance'] == 1
                          ? "sentence_test_result_stability".tr
                          : "sentence_test_result_pitch_high".tr),
                  style: const TextStyle(
                    color: ColorSystem.black,
                    fontSize: 14,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'sentence_test_result_speed'.tr,
                  style: const TextStyle(
                    color: ColorSystem.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _getSpeedDescription(model.response['speed'] ?? 1),
                  style: const TextStyle(
                    color: ColorSystem.black,
                    fontSize: 14,
                  ),
                ),
                WordVibrationWidget(),
                WordVibrationWidget(),
              ],

            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'next'.tr,
            style: const TextStyle(
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
      return 'sentence_test_result_speed_very_slow'.tr;
    case 0.5:
      return 'sentence_test_result_speed_slow'.tr;
    case 1:
      return 'sentence_test_result_speed_normal'.tr;
    case 1.5:
      return 'sentence_test_result_speed_fast'.tr;
    case 2:
      return 'sentence_test_result_speed_very_fast'.tr;
    default:
      return 'unknown'.tr; // 속도 값이 주어진 범위에 없는 경우
  }
}
