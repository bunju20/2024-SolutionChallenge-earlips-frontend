import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:earlips/views/word/widget/blue_back_appbar.dart';
import 'package:earlips/views/word/widget/word_list_widget.dart';
import 'package:earlips/views/word/widget/word_youtube_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:earlips/views/paragraph/create_script_screen.dart';

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
                  const SizedBox(
                    height: 70,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "아래의 혀, 입술 모양을 따라 말해보세요!",
                          style: TextStyle(
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
                  return const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: YoutubeWordPlayer(),
                  );
                } else {
                  return Container(
                    child: CreateScriptPage(),
                  );
                }
              },
            ),
            const Spacer(),
            // wordViewModel   final String video로 영상 유튜브 링크를 바로 볼 수 있게 하기
            ElevatedButton(
              onPressed: () async {
                await wordViewModel.markWordAsDone(wordViewModel
                    .wordList[wordViewModel.currentIndex.value].wordCard);

                Get.dialog(
                  AlertDialog(
                    title: const Text('학습 완료'),
                    content: const Text('다음으로 넘어가려면 아래 버튼을 눌러주세요.'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                          if (wordViewModel.currentIndex.value <
                              wordViewModel.wordList.length - 1) {
                            pageController.animateToPage(
                              wordViewModel.currentIndex.value + 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                            wordViewModel.currentIndex.value =
                                wordViewModel.currentIndex.value + 1;
                          }
                        },
                        child: const Text('다음으로 넘어가기'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("학습 완료"),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
