import 'package:earlips/models/word_data_model.dart';
import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/viewModels/record/record_viewmodel.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX library

class WordSentenceWidget extends StatelessWidget {
  final List<WordData> wordDataList;
  final int type;

  PageController pageController = PageController();

  WordSentenceWidget(
      {super.key,
      required this.wordDataList,
      required this.pageController,
      required this.type});

  @override
  Widget build(BuildContext context) {
    Get.put(RecordViewModel());
    final wordViewModel = Get.find<WordViewModel>();

    return GetBuilder<RecordViewModel>(
      builder: (RecordViewModel model) {
        return Center(
          child: Column(
            children: [
              Align(
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
                        await model.sendTextAndAudio(
                            wordDataList[wordViewModel.currentIndex.value]
                                .wordCard
                                .word,
                            type);

                        // Handle the response here, e.g., show it in a dialog
                        if (type == 2) {
                          // 타입이 2일 경우, 문장 교정 정보를 보여주는 대화상자를 표시
                          Get.dialog(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                    SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          userWords:
                                              model.response['user_word'],
                                          wrongIndices: model.response['wrong'],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                    SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                    SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '변동성',
                                          style: TextStyle(
                                            color: ColorSystem.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                            '${model.response['variance'] == 1 ? "일정함" : "변동 폭 큼"}',
                                            style: const TextStyle(
                                              color: ColorSystem.black,
                                              fontSize: 14,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          _getSpeedDescription(
                                              model.response['speed']),
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
                                    await wordViewModel.markWordAsDone(
                                        wordViewModel
                                            .wordList[wordViewModel
                                                .currentIndex.value]
                                            .wordCard);
                                    wordViewModel.currentIndex.value <
                                            wordViewModel.wordList.length - 1
                                        ? Get.back()
                                        : Get.offAllNamed('/');

                                    // 다음 단어로 넘어가기
                                    if (wordViewModel.currentIndex.value <
                                        wordViewModel.wordList.length - 1) {
                                      pageController.animateToPage(
                                        wordViewModel.currentIndex.value + 1,
                                        duration:
                                            const Duration(milliseconds: 300),
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
                        } else {
                          Get.dialog(
                            AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              insetPadding: const EdgeInsets.all(20),
                              surfaceTintColor: ColorSystem.white,
                              title: const Text(
                                '결과',
                                style: TextStyle(
                                  color: ColorSystem.black,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              content: GetBuilder<RecordViewModel>(
                                builder: (model) => SizedBox(
                                  height: 100,
                                  child: Column(
                                    textBaseline: TextBaseline.alphabetic,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        model.response['pronunciation'] != null
                                            ? '발음: ${model.response['pronunciation']}'
                                            : '너무 빠르거나 느립니다. 다시 녹음해주세요',
                                        style: const TextStyle(
                                          color: ColorSystem.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                          model.response['similarity'] != null
                                              ? '정확도: ${model.response['similarity']}'
                                              : "",
                                          style: const TextStyle(
                                            color: ColorSystem.black,
                                            fontSize: 16,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                    if (model.response['similarity'] >= 70) {
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
                                          backgroundColor: ColorSystem.white,
                                          surfaceTintColor: ColorSystem.white,
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                Get.back();
                                              },
                                              child: const Text('다시하기'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
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
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 10, 30, 10),
                                      decoration: BoxDecoration(
                                        color: ColorSystem.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: ColorSystem.black),
                                      ),
                                      child: const Text(
                                        '확인',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ColorSystem.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        // 녹음 시작
                        model.sendTextAndAudio('content', 0);
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
            ],
          ),
        );
      },
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
}

class HighlightMistakesTextWidget extends StatelessWidget {
  final List<dynamic> userWords; // 사용자가 발음한 단어 리스트
  final List<dynamic> wrongIndices; // 잘못 발음한 단어의 인덱스 리스트

  HighlightMistakesTextWidget({
    Key? key,
    required this.userWords,
    required this.wrongIndices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return wrongIndices[0] == -1
        ? Text("틀린단어 없음")
        : RichText(
            text: TextSpan(
              children: userWords.asMap().entries.map((entry) {
                int idx = entry.key;
                String word = entry.value;
                bool isWrong = wrongIndices.contains(idx);
                return TextSpan(
                  text: "$word ", // 단어와 공백을 포함시킵니다.
                  style: TextStyle(
                    color: isWrong
                        ? Colors.red
                        : Colors.black, // 잘못된 부분은 빨간색으로, 그 외는 검정색으로 표시
                  ),
                );
              }).toList(),
            ),
          );
  }
}
