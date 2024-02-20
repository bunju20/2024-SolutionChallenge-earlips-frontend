import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class RecordViewModel extends GetxController {
  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();

  final RxBool isRecording = false.obs;
  RxString audioFilePath = ''.obs;
  final RxMap<String, dynamic> response =
      <String, dynamic>{}.obs; // Specify the types

  @override
  void onInit() {
    _requestPermission();
    super.onInit();
  }

  Future<void> _requestPermission() async {
    var microphoneStatus = await Permission.microphone.status;
    if (!microphoneStatus.isGranted) {
      await Permission.microphone.request();
    }
  }

  Future<void> _startRecording() async {
    if (isRecording.value) return;

    // Ensure the recorder is open
    if (!_audioRecorder.isStopped) {
      await _audioRecorder.closeRecorder();
    }

    // Open the recorder
    await _audioRecorder.openRecorder();
    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.aac';

    print('Recording to $filePath');
    try {
      await _audioRecorder.startRecorder(
        toFile: filePath,
        codec: Codec.aacADTS,
      );

      isRecording.value = true;
    } catch (e) {
      print('Error starting recorder: $e');
      // Handle the error as needed
    }
  }

  Future<String?> _stopRecording() async {
    try {
      final path = await _audioRecorder.stopRecorder();
      audioFilePath.value = path!;
      isRecording.value = false;
      return path; // 녹음이 중지된 파일의 경로를 반환합니다.
    } catch (e) {}
    return null;
  }

  Future<void> sendTextAndAudio(String content) async {
    String url = '${dotenv.env['API_URL']!}/study/syllable';
    print('Sending data and audio to $url');
    print('audioFilePath.value: ${audioFilePath.value}');
    print('content: $content');
    if (audioFilePath.value.isEmpty) {
      print('Audio file is not available.');
      return;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['content'] = content
        ..files.add(
            await http.MultipartFile.fromPath('audio', audioFilePath.value));

      print('Sending data and audio...----------------------------');
      var response = await request.send();
      if (response.statusCode == 200) {
        // Read the response stream and convert it to a JSON object
        final respStr = await response.stream.bytesToString();
        final jsonResponse = json.decode(respStr);

        // Store the response in the RxMap
        this.response.value = jsonResponse;
      } else {
        print(
          'Failed to send data and audio. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print(e.toString());
    }
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
