import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> SucessWordDialogWidget(
    WordViewModel wordViewModel, PageController pageController) {
  return Get.dialog(
    AlertDialog(
      title: const Text('학습 완료'),
      content: const Text('다음으로 넘어가려면 아래 버튼을 눌러주세요.'),
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
          child: const Text('다음 단어'),
        ),
      ],
    ),
  );
}
