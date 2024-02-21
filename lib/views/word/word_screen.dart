import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:earlips/views/word/widget/blue_back_appbar.dart';
import 'package:earlips/views/word/widget/word_list_widget.dart';
import 'package:earlips/views/word/widget/word_sentence_widget.dart';
import 'package:earlips/views/word/widget/word_youtube_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:earlips/views/paragraph/learning_session_screen.dart';

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
      body: Center(
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
                              ? "문장의 높낮이를 참고하세요"
                              : "아래의 혀, 입술 모양을 따라 말해보세요!",
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
                if (controller.type < 2) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const YoutubeWordPlayer(),
                        const SizedBox(
                          height: 100,
                        ),
                        WordSentenceWidget(
                          pageController: pageController,
                          wordDataList: controller.wordList,
                          type: controller.type,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  );
                } else if (controller.type == 2) {
                  return Column(
                    children: [
                      WordSentenceWidget(
                        pageController: pageController,
                        wordDataList: controller.wordList,
                        type: controller.type,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  );
                } else {
                  return LearningSessionScreen();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
