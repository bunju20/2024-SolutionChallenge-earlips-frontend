import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class RecordViewModel extends GetxController {
  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  bool _isRecorderInitialized = false; // 녹음기 초기화 여부 : 파일
  final RxBool isRecording = false.obs;
  RxString audioFilePath = ''.obs;
  final RxMap<String, dynamic> response =
      <String, dynamic>{}.obs; // Specify the types

  @override
  void onInit() {
    _requestPermission();
    super.onInit();
  }

// 요청 권한
  Future<void> _requestPermission() async {
    var microphoneStatus = await Permission.microphone.status;
    if (!microphoneStatus.isGranted) {
      await Permission.microphone.request();
    }
  }

  Future<void> _startRecording() async {
    if (!_isRecorderInitialized || isRecording.value) return;
    if (!_audioRecorder.isStopped) {
      await _audioRecorder.closeRecorder();
    }

    // Open the recorder
    await _audioRecorder.openRecorder();
    _isRecorderInitialized = true;
    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.aac';
    try {
      await _audioRecorder.startRecorder(
        toFile: filePath,
        codec: Codec.aacADTS,
      );

      isRecording.value = true;
    } catch (_) {}
  }

  Future<String?> _stopRecording() async {
    try {
      final path = await _audioRecorder.stopRecorder();
      audioFilePath.value = path!;
      isRecording.value = false;
      //  파일 디코딩하여 유효성 확인

      return path; // 녹음이 중지된 파일의 경로를 반환합니다.
    } catch (_) {}
    return null;
  }

  Future<void> sendTextAndAudio(String content, int type) async {
    String url =
        '${dotenv.env['API_URL']!}/study/${type == 0 ? 'syllable' : (type == 1 ? 'word' : 'sentence')}';

    print(audioFilePath.value);
    if (audioFilePath.value.isEmpty) {
      return;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['content'] = content
        ..files.add(
            await http.MultipartFile.fromPath('audio', audioFilePath.value));

      var response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final jsonResponse = json.decode(respStr);
        //
        this.response.value = jsonResponse;
      } else {}
    } catch (e) {}
  }

  void toggleRecording() async {
    isRecording.value ? await _stopRecording() : await _startRecording();
    update();
  }

  @override
  void onClose() {
    _audioRecorder.closeRecorder();
    super.onClose();
  }
}
