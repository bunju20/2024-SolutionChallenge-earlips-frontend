import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> FailWordDialogWidget(
    WordViewModel wordViewModel, PageController pageController) {
  return Get.dialog(
    AlertDialog(
      title: Text('fail_study_title'.tr),
      content: Text('fail_study_content'.tr),
      backgroundColor: ColorSystem.white,
      surfaceTintColor: ColorSystem.white,
      actions: [
        ElevatedButton(
          onPressed: () async {
            Get.back();
          },
          child: Text('fail_study_retry'.tr),
        ),
        ElevatedButton(
          onPressed: () async {
            // 마지막 단어가 아닐 경우 뒤로가기, 마지막 단어일 경우 홈으로 이동
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
          child: Text('fail_study_next_word'.tr),
        ),
      ],
    ),
  );
}
