import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class RealCreateViewModel extends GetxController {
  final speechToText = stt.SpeechToText();
  var isRecording = false.obs;
  var handDone = false.obs; // 추가
  var text = ''.obs;

  @override
  void onInit() {
    super.onInit();
    requestPermission();
  }

  void toggleRecording() {
    print("녹음 버튼 클릭" );
    if (isRecording.value) {
      print("이제 끌게용");
      handDone.value = true;
      stopListening();
    } else {
      print("이제 시작할게용");
      handDone.value = false;
      isRecording.value = true;
      startListening();
    }
  }
  void startListening() async {
    bool available = await speechToText.initialize(onStatus: handleStatus);
    if (available) {
      speechToText.listen(onResult: (result) {
        if (result.finalResult) {
          // 기존 텍스트에 이어서 새로 인식된 텍스트를 추가합니다.
          text.value += "${result.recognizedWords} ";
        }
    },
  listenFor: const Duration(minutes: 5),
  pauseFor: const Duration(seconds: 3),
  );
      isRecording.value = true;
    }
  }

  void stopListening() {
    speechToText.stop();
    isRecording.value = false;
  }

  void handleStatus(String status) {
    print("현재 상태: $status");
    print("handDone: $handDone");
    print("isRecording: $isRecording");
    if (handDone.value) {
      return;
    }
    if (status == 'done') {
      stopListening();
      Future.delayed(Duration(milliseconds: 100), () {
        startListening();
      });
      if (status == 'notListening') {
        startListening();
      }
    }
  }

  Future<void> requestPermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
    }
  }

  @override
  void onClose() {
    speechToText.stop();
    super.onClose();
  }
}
