import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';


class WordVibrationWidget extends StatelessWidget {
  const WordVibrationWidget({super.key, this.externalPattern, this.externalIntensities});

  final List<int>? externalPattern;
  final List<int>? externalIntensities;

  @override
  Widget build(BuildContext context) {
    final wordViewModel = Get.find<WordViewModel>();

    return Obx(() {
      if (wordViewModel.currentIndex.value >= 0 && wordViewModel.currentIndex.value < wordViewModel.wordList.length) {
        final currentWordCard = wordViewModel.wordList[wordViewModel.currentIndex.value].wordCard;
        final List<int>? pattern = externalPattern != null ? externalPattern : currentWordCard.pattern;
        final List<int>? intensities = externalIntensities != null ? externalIntensities : currentWordCard.intensities;


        print('pattern: $pattern');
        print('intensities: $intensities');

        return Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Container(
                  width: Get.width * 0.33,
                  child: Row(
                    children: [
                      Text('진동으로 들어보기'),
                      const SizedBox(width: 10),
                      Icon(Icons.vibration),
                    ],
                  ),
                ),
                onPressed: () {
                  Vibration.vibrate(
                    pattern: pattern!,
                    intensities: intensities!,
                  );
                },
              ),
            ],
          ),
        );
      } else {
        return Center(child: Text('Invalid index or word list empty'));
      }
    });
  }
}
