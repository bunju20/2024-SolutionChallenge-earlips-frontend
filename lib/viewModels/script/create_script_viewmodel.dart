import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:earlips/views/script/analyze_screen.dart';
import 'package:earlips/viewModels/script/analyze_viewmodel.dart';

class CreateScriptViewModel extends ChangeNotifier {
  bool isRecording = false;
  bool _isRecorderInitialized = false; // 녹음기 초기화 여부 : 파일
  bool _isRecording = false; // 녹음 중 여부 : 파일
  FlutterSoundRecorder? _audioRecorder;
  String audioFilePath = '';
  // 사용자 로그인 상태를 확인하는 함수
  bool get isLoggedIn => FirebaseAuth.instance.currentUser != null;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool handDone = false;
  TextEditingController writedTextController =
      TextEditingController(); // 사용자 입력을 위한 컨트롤러
  TextEditingController voicedTextController =
      TextEditingController(); // 음성 인식 결과를 위한 컨트롤러
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
    final filePath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.aac';

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
      return path; // 녹음이 중지된 파일의 경로를 반환합니다.
    } catch (e) {
      return null;
    }
  }

  Future<void> sendTextAndAudio() async {
    String url = '${dotenv.env['API_URL']!}/script';
    String textToSend = writedTextController.text;
    if (audioFilePath.isEmpty) {
      return;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['content'] = textToSend // 'content' 필드 이름으로 수정
        ..files.add(await http.MultipartFile.fromPath(
            'audio', audioFilePath)); // 'audio' 필드 이름은 그대로 유지

      var response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final jsonResponse = json.decode(respStr);
        if (jsonResponse != null) {
          final analyzeViewModel = Get.find<AnalyzeViewModel>();

          analyzeViewModel.updateData({
            'paragraph_word': jsonResponse['paragraph_word'],
            'user_word': jsonResponse['user_word'],
            'paragraph_sentence': jsonResponse['paragraph_sentence'],
            'user_sentence': jsonResponse['user_sentence'],
            'wrong': jsonResponse['wrong'],
            'speed': jsonResponse['speed'],
          });

          Get.to(() => const AnalyzeScreen()); // AnalyzeScreen으로 이동
        } else {}
      } else {}
    } catch (_) {}
    if (!isLoggedIn) {
    } else {
      saveDataToFirestore();
    }
  }

  void _handleStatus(String status) {
    if (handDone) return;
    if (status == 'done') {
      stopListening();
      Future.delayed(const Duration(milliseconds: 100), () {
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
      return;
    }
    speechToText.listen(
      onResult: (result) {
        if (result.finalResult) {
          voicedTextController.text += "${result.recognizedWords} ";
          notifyListeners();
        }
      },
      listenFor: const Duration(minutes: 5),
      pauseFor: const Duration(seconds: 3),
    );
  }

  Future<void> stopListening() async {
    speechToText.stop();
    notifyListeners();
  }

  void complete() async {
    await sendTextAndAudio(); // 비동기 호출로 수정
  }

  Future<void> saveDataToFirestore() async {
    final uid = _auth.currentUser?.uid;
    if (!isLoggedIn) {
      return;
    }
    final textToSend = writedTextController.text;
    final title =
        textToSend.length > 5 ? '${textToSend.substring(0, 5)}...' : textToSend;
    final dateFormat = Timestamp.now(); // 현재 시간을 Timestamp 형태로 저장

    final documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('paragraph')
        .doc(); // 새 문서 ID를 자동 생성

    await documentReference
        .set({
          'dateFormat': dateFormat,
          'text': textToSend,
          'title': title,
        })
        .then((_) {})
        .catchError((_) {});
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
