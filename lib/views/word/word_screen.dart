import 'package:earlips/models/phoneme_model.dart';
import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:earlips/views/phoneme/phoneme_detail_Screen.dart';
import 'package:earlips/views/word/widget/blue_back_appbar.dart';
import 'package:earlips/views/word/widget/word_list_widget.dart';
import 'package:earlips/views/word/widget/word_sentence_widget.dart';
import 'package:earlips/views/word/widget/word_vibration_widget.dart';
import 'package:earlips/views/word/widget/word_youtube_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:earlips/views/script/learning_session_screen.dart';

class PhoneticButtons extends StatelessWidget {
  final String phoneticString;

  const PhoneticButtons({super.key, required this.phoneticString});

  @override
  Widget build(BuildContext context) {
    // Splitting the phonetic string into components
    List<String> phonemes1 = phoneticString.replaceAll('/', '').split('.');
    List<String> phonemes2 = 'b.juː.t.ɪ.f.ə.l'.split('.');

    return Column(
      children: [
        const Text("Split Phonemes",
            style: TextStyle(
                fontSize: 16,
                color: ColorSystem.black,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0, // Space between buttons
          children: phonemes1
              .map((phoneme) => ElevatedButton(
                    onPressed: () {
                      // Navigate to a detail page for the phoneme
                      Get.to(() => PhonemeDetailScreen(
                          phoneme: Phoneme(
                              symbol: phoneme, description: '', imageSrc: '')));
                    },
                    child: Text(phoneme,
                        style: const TextStyle(
                            fontSize: 16, color: ColorSystem.black)),
                  ))
              .toList(),
        ),
        const SizedBox(height: 20),
        const Text("More Detail",
            style: TextStyle(
                fontSize: 16,
                color: ColorSystem.black,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0, // Space between buttons
          children: phonemes2
              .map((phoneme) => ElevatedButton(
                    onPressed: () {
                      // Navigate to a detail page for the phoneme
                      Get.to(() => PhonemeDetailScreen(
                          phoneme: Phoneme(
                              symbol: phoneme, description: '', imageSrc: '')));
                    },
                    child: Text(phoneme,
                        style: const TextStyle(
                            fontSize: 16, color: ColorSystem.black)),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

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
                if (controller.type <= 2) {

                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // 유투브 영상 나옴
                        const YoutubeWordPlayer(),
                        if(controller.type == 0)SizedBox(
                          height: 100,
                        ),
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
                }
                else {
                  return LearningSessionScreen(isStudyMode: true);

                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
