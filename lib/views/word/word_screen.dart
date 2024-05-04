import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:earlips/views/word/widget/blue_back_appbar.dart';
import 'package:earlips/views/word/widget/phonetic_buttons_widget.dart';
import 'package:earlips/views/word/widget/word_list_widget.dart';
import 'package:earlips/views/word/widget/word_sentence_widget.dart';
import 'package:earlips/views/word/widget/word_vibration_widget.dart';
import 'package:earlips/views/word/widget/word_youtube_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:earlips/views/script/learning_session_screen.dart';

class WordScreen extends StatelessWidget {
  final String title;
  final int type;

  const WordScreen({super.key, required this.title, required this.type});
  @override
  Widget build(BuildContext context) {
    final wordViewModel = Get.put(WordViewModel(
      type: type,
    ));

    final PageController pageController =
        PageController(initialPage: wordViewModel.currentIndex.value);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlueBackAppbar(title: title),
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Center(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: ColorSystem.main2,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      GetBuilder<WordViewModel>(
                        // Add GetBuilder here
                        builder: (controller) => WordList(
                          // viewmodel
                          wordDataList: controller.wordList,
                          type: type,
                          pageController: pageController,
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              type == 2
                                  ? "word_type_2_height".tr
                                  : "word_type_12_height".tr,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: ColorSystem.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // wordViewModel   final String video로 영상 유튜브 링크를 바로 볼 수 있게 하기
                GetBuilder<WordViewModel>(
                  builder: (controller) {
                    if (controller.wordList.isEmpty) {
                      return const Center(child: Text("No data available"));
                    }

                    /// -------------------- --------- --------------------
                    /// -------------------- 단어 교정 --------------------
                    /// -------------------- --------- --------------------
                    if (controller.type == 1) {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Column(children: [
                            // 유투브 영상 나옴
                            const WordVibrationWidget(),
                            const SizedBox(
                              height: 10,
                            ),
                            Image.asset("assets/images/word.gif",
                              width: Get.width * 0.8,),
                            //
                            // Text(
                            //   controller.wordList[0].wordCard.speaker,
                            //   style: const TextStyle(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.w600,
                            //     color: ColorSystem.black,
                            //   ),
                            // ),
                            const SizedBox(height: 20),
                            PhoneticButtons(
                              phoneticString:
                                  controller.wordList[0].wordCard.speaker,
                              realString: controller.wordList[0].wordCard.word,
                              description: wordViewModel.description.value,
                            ),

                            WordSentenceWidget(
                              pageController: pageController,
                              wordDataList: controller.wordList,
                              type: controller.type,
                            )
                          ]));
                    }

                    /// -------------------- --------- --------------------
                    /// -------------------- 문장 교정 --------------------
                    /// -------------------- --------- --------------------
                    if (controller.type == 2) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Column(
                          children: [
                            const WordVibrationWidget(),
                            const SizedBox(
                              height: 10,
                            ),
                            // 유투브 영상
                            Image.asset("assets/images/sentance.gif",
                            width: Get.width * 0.8,),
                            const SizedBox(height: 20),
                            // 단어 분리
                            PhoneticButtons(
                              phoneticString:
                                  controller.wordList[0].wordCard.speaker,
                              realString: controller.wordList[0].wordCard.word,
                              description: wordViewModel.description.value,
                            ),
                            // 녹음 버튼
                            WordSentenceWidget(
                              pageController: pageController,
                              wordDataList: controller.wordList,
                              type: controller.type,
                            ),

                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      );
                    } else {
                      /// -------------------- --------- --------------------
                      /// -------------------- 문단 교정 --------------------
                      /// -------------------- --------- --------------------
                      return const LearningSessionScreen(isStudyMode: true);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
