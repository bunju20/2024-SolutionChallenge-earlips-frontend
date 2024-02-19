import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:earlips/views/script/analyze_screen.dart';
import 'package:earlips/viewModels/script/analyze_viewmodel.dart';


class CreateScriptViewModel extends ChangeNotifier {
  bool isRecording = false;
  bool _isRecorderInitialized = false; // 녹음기 초기화 여부 : 파일
  bool _isRecording = false; // 녹음 중 여부 : 파일
  FlutterSoundRecorder? _audioRecorder;
  String audioFilePath = '';


  bool handDone = false;
  TextEditingController writedTextController = TextEditingController(); // 사용자 입력을 위한 컨트롤러
  TextEditingController voicedTextController = TextEditingController(); // 음성 인식 결과를 위한 컨트롤러
  stt.SpeechToText speechToText = stt.SpeechToText();

  CreateScriptViewModel() {
    _init();
    _initRecorder();
  }

  void _init() async {
    Get.put(AnalyzeViewModel());
    await requestPermission();
    speechToText.initialize(
      onError: (val) => print('Error: $val'),
      onStatus: _handleStatus,
    );
  }

  Future<void> _initRecorder() async {
    _audioRecorder = FlutterSoundRecorder();

    await _audioRecorder?.openRecorder();
    _isRecorderInitialized = true;
  }

  Future<void> _startRecording() async {
    if (!_isRecorderInitialized || _isRecording) return;

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/${DateTime
        .now()
        .millisecondsSinceEpoch}.aac';

    await _audioRecorder!.startRecorder(
      toFile: filePath,
      codec: Codec.aacADTS,
    );

    _isRecording = true;
  }

  Future<String?> _stopRecording() async {
    try {
      final path = await _audioRecorder!.stopRecorder();
      audioFilePath = path!;
      _isRecording = false;
      print('Recording stopped, file path: $path');
      return path; // 녹음이 중지된 파일의 경로를 반환합니다.
    } catch (e) {
      print('Error stopping recorder: $e');
      return null;
    }
  }


  Future<void> sendTextAndAudio() async {
    String url = 'https://962554f7-5348-4141-a3df-1a50c06b79b5-00-15gg2xcmiy7a0.sisko.replit.dev/upload';
    String textToSend = writedTextController.text;
    if (audioFilePath.isEmpty) {
      print('Audio file is not available.');
      return;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['text'] = textToSend
        ..files.add(await http.MultipartFile.fromPath('audio', audioFilePath));

      var response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final jsonResponse = json.decode(respStr);
        print('Server response: $respStr');

        if (jsonResponse != null && jsonResponse['data'] != null) {
          final analyzeViewModel = Get.find<AnalyzeViewModel>();
          analyzeViewModel.updateData(jsonResponse['data']);
          Get.to(() => AnalyzeScreen()); // AnalyzeScreen으로 이동
        } else {
          print('Received null or invalid data from the server.');
        }
      } else {
        print('Failed to send data and audio. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }




  void _handleStatus(String status) {
    if (handDone) return;
    if (status == 'done') {
      stopListening();
      Future.delayed(Duration(milliseconds: 100), () {
        startListening();
      });
    }
    notifyListeners();
  }

  Future<void> requestPermission() async {
    var microphoneStatus = await Permission.microphone.status;
    if (!microphoneStatus.isGranted) {
      await Permission.microphone.request();
    }
  }

  void toggleRecording() async {
    isRecording ? stopListening() : startListening();
    _isRecording ? await _stopRecording() : _startRecording();
    handDone = isRecording;
    isRecording = !isRecording;
    notifyListeners();
  }

  Future<void> startListening() async {
    bool available = await speechToText.initialize();
    if (!available) {
      print("The user has denied the use of speech recognition.");
      return;
    }
    speechToText.listen(
      onResult: (result) {
        if (result.finalResult) {
          voicedTextController.text += result.recognizedWords + " ";
          notifyListeners();
        }
      },
      listenFor: Duration(minutes: 5),
      pauseFor: Duration(seconds: 3),
    );
  }

  Future<void> stopListening() async {
    speechToText.stop();
    notifyListeners();
  }

  void complete() async {
    print("완료버튼 눌렀습니다.");
    await sendTextAndAudio(); // 비동기 호출로 수정
  }


  Future<void> sendText() async {
    String url = 'https://heheds.free.beeceptor.com';
    String textToSend = writedTextController.text;

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'text': textToSend},
      );

      if (response.statusCode == 200) {
        // 요청이 성공적으로 완료되었습니다.
        print('Data sent successfully');
      } else {
        // 서버 오류가 발생했습니다.
        print('Failed to send data');
      }
    } catch (e) {
      // 네트워크 요청 중 오류가 발생했습니다.
      print(e.toString());
    }

    @override
    void dispose() {
      // 컨트롤러들을 정리합니다.
      if (_audioRecorder != null) {
        _audioRecorder!.closeRecorder();
        _audioRecorder = null;
      }
      writedTextController.dispose();
      voicedTextController.dispose();
      super.dispose();
    }
  }
}