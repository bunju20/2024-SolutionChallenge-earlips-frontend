import 'package:earlips/models/word_data_model.dart';
import 'package:earlips/viewModels/record/record_viewmodel.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX library

class WordSentenceWidget extends StatelessWidget {
  final List<WordData> wordDataList;
  final int type;
  // pageController
  PageController pageController = PageController();

  WordSentenceWidget(
      {super.key,
      required this.wordDataList,
      required this.pageController,
      required this.type});

  @override
  Widget build(BuildContext context) {
    Get.put(RecordViewModel()); // Ensure RecordViewmodel is initialized
    final wordViewModel = Get.find<WordViewModel>(); // Access your ViewModel!

    return GetBuilder<RecordViewModel>(
      builder: (RecordViewModel model) {
        return Center(
          child: Column(
            children: [
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Ink(
                    decoration: BoxDecoration(
                      color: model.isRecording.value ? Colors.red : Colors.blue,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: () async {
                        if (model.isRecording.value) {
                          // 녹음 토글 버튼
                          model.toggleRecording();

                          await model.sendTextAndAudio(
                              wordDataList[wordViewModel.currentIndex.value]
                                  .wordCard
                                  .word,
                              type);
                          // Handle the response here, e.g., show it in a dialog
                          Get.dialog(
                            // height
                            AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: const Text('결과'),
                              content: GetBuilder<RecordViewModel>(
                                builder: (model) => Column(
                                  children: [
                                    Text(
                                      '발음: ${model.response['pronunciation']}',
                                    ),
                                    Text(
                                      '정확도: ${model.response['similarity']}',
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                    if (model.response['similarity'] == null) {
                                      return;
                                    }
                                    if (model.response['similarity'] >= 80) {
                                      Get.dialog(
                                        AlertDialog(
                                          title: const Text('학습 완료'),
                                          content: const Text(
                                              '다음으로 넘어가려면 아래 버튼을 눌러주세요.'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                await wordViewModel
                                                    .markWordAsDone(wordViewModel
                                                        .wordList[wordViewModel
                                                            .currentIndex.value]
                                                        .wordCard);
                                                wordViewModel.currentIndex
                                                            .value <
                                                        wordViewModel.wordList
                                                                .length -
                                                            1
                                                    ? Get.back()
                                                    : Get.offAllNamed('/');

                                                // 다음 단어로 넘어가기
                                                if (wordViewModel
                                                        .currentIndex.value <
                                                    wordViewModel
                                                            .wordList.length -
                                                        1) {
                                                  pageController.animateToPage(
                                                    wordViewModel.currentIndex
                                                            .value +
                                                        1,
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.ease,
                                                  );

                                                  // currentIndex 증가
                                                  wordViewModel.currentIndex
                                                      .value = wordViewModel
                                                          .currentIndex.value +
                                                      1;
                                                }
                                              },
                                              child: const Text('다음 단어'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      // 80 미만일 경우 다른 AlertDialog를 표시 다시하기 혹은 다음으로
                                      Get.dialog(
                                        AlertDialog(
                                          title: const Text('학습 실패'),
                                          content: const Text('다시 한번 녹음해주세요.'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                Get.back();
                                              },
                                              child: const Text('다시하기'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                Get.back();
                                                // 마지막 단어가 아닐 경우 뒤로가기, 마지막 단어일 경우 홈으로 이동
                                                wordViewModel.currentIndex
                                                            .value <
                                                        wordViewModel.wordList
                                                                .length -
                                                            1
                                                    ? Get.back()
                                                    : Get.offAllNamed('/');

                                                // 다음 단어로 넘어가기
                                                if (wordViewModel
                                                        .currentIndex.value <
                                                    wordViewModel
                                                            .wordList.length -
                                                        1) {
                                                  pageController.animateToPage(
                                                    wordViewModel.currentIndex
                                                            .value +
                                                        1,
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.ease,
                                                  );

                                                  // currentIndex 증가
                                                  wordViewModel.currentIndex
                                                      .value = wordViewModel
                                                          .currentIndex.value +
                                                      1;
                                                }
                                              },
                                              child: const Text('다음 단어'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // Start recording
                          model.toggleRecording();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Icon(
                          model.isRecording.value ? Icons.stop : Icons.mic,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
