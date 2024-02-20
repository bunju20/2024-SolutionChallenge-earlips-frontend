import 'dart:io';

import 'package:earlips/models/word_data_model.dart';
import 'package:earlips/viewModels/record/record_viewmodel.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart'; // Import GetX library
import 'package:permission_handler/permission_handler.dart';

class WordSentenceWidget extends StatelessWidget {
  final List<WordData> wordDataList;

  const WordSentenceWidget({super.key, required this.wordDataList});

  @override
  Widget build(BuildContext context) {
    Get.put(RecordViewModel()); // Ensure RecordViewmodel is initialized
    final wordViewModel = Get.find<WordViewModel>(); // Access your ViewModel!

    return GetBuilder<RecordViewModel>(
      builder: (RecordViewModel model) {
        return Center(
          child: Column(
            children: [
              const Text('WordSentenceWidget'),
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
                          // Stop recording and send text and audio
                          model.toggleRecording();
                          // wordDataList[wordViewModel.currentIndex.value]
                          //         .wordCard
                          //         .word
                          await model.sendTextAndAudio("희찬");

                          // Handle the response here, e.g., show it in a dialog
                          Get.dialog(
                            AlertDialog(
                              title: const Text('Response from Server'),
                              content: GetBuilder<RecordViewModel>(
                                builder: (model) => Column(
                                  children: [
                                    Text(
                                      'Pronunciation: ${model.response['pronunciation']}',
                                    ),
                                    Text(
                                      'Similarity: ${model.response['similarity']}',
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
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
