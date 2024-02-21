import 'package:earlips/models/word_data_model.dart';
import 'package:earlips/viewModels/record/record_viewmodel.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:earlips/views/word/widget/sentence_alert_widget.dart';
import 'package:earlips/views/word/widget/word_result_dialog_widget.dart';
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
                        if (type == 2) {
                          // 타입이 2일 경우, 문장 교정 정보를 보여주는 대화상자를 표시
                          SentenceAlertWidget(
                              model, wordViewModel, pageController);
                        } else {
                          WordResultDialogWidget(
                              model, wordViewModel, pageController);
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
}
