import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> SucessWordDialogWidget(
    WordViewModel wordViewModel, PageController pageController) {
  return Get.dialog(
    AlertDialog(
      title: Text('success_study_title'.tr),
      content: Text('success_study_content'.tr),
      actions: [
        ElevatedButton(
          onPressed: () async {
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
          child: Text('fail_study_next_word'.tr),
        ),
      ],
    ),
  );
}
