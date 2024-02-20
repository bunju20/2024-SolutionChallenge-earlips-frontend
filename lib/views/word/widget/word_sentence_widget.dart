// word_sentence_widget.dart
import 'dart:io';

import 'package:earlips/models/word_data_model.dart';
import 'package:earlips/viewModels/record/record_viewmodel.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

class WordSentenceWidget extends StatelessWidget {
  final List<WordData> wordDataList;
  const WordSentenceWidget({super.key, required this.wordDataList});

  @override
  Widget build(BuildContext context) {
    final wordViewModel = Get.find<WordViewModel>(); // Access your ViewModel!
    return GetBuilder<RecordViewModel>(
      init: RecordViewModel(),
      builder: (viewModel) => Center(
        child: Column(
          children: [
            const Text('WordSentenceWidget'),
            StreamBuilder<RecordingDisposition>(
                stream: viewModel.recorder.onProgress,
                builder: (context, snapshot) {
                  final disposition = snapshot.hasData
                      ? snapshot.data!.duration
                      : Duration.zero;

                  return Text('Recorder: ${disposition.inSeconds}s');
                }),
            ElevatedButton(
              onPressed: () async {
                if (viewModel.recorder.isRecording) {
                  await viewModel.stopRecording(
                      wordDataList[wordViewModel.currentIndex.value]
                          .wordCard
                          .word);
                } else {
                  await viewModel.startRecording();
                }
              },
              child: Icon(
                viewModel.recorder.isRecording ? Icons.stop : Icons.mic,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
