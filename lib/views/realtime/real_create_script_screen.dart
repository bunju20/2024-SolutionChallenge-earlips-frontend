import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class RealCreateScriptPage extends StatefulWidget {
  @override
  _RealCreateScriptPageState createState() => _RealCreateScriptPageState();
}

class _RealCreateScriptPageState extends State<RealCreateScriptPage> {
  bool isRecording = false;
  TextEditingController textEditingController = TextEditingController();
  stt.SpeechToText speechToText = stt.SpeechToText();

  @override
  void initState() {
    super.initState();
    requestPermission();
    speechToText.initialize(onError: (val) => print('Error: $val'), onStatus: (val) => print('Status: $val'));
  }

  Future<void> requestPermission() async {
    var microphoneStatus = await Permission.microphone.status;
    if (!microphoneStatus.isGranted) {
      await Permission.microphone.request();
    }
  }

  void toggleRecording() {
    if (isRecording) {
      stopListening();
    } else {
      startListening();
    }
  }

  void startListening() async {
    bool available = await speechToText.initialize(onError: (error) => print(error), onStatus: (status) => print(status));
    if (!available) {
      print("The user has denied the use of speech recognition or an error occurred during initialization.");
      return;
    }
    // 음성 인식을 시작하기 전에 텍스트 필드를 초기화합니다.
    textEditingController.text = "";
    speechToText.listen(
      onResult: (result) {
        setState(() {
          // 인식된 결과가 최종 결과인 경우에만 텍스트를 업데이트합니다.
          if (result.finalResult) {
            // 기존에 누적되지 않도록 이전 결과를 덮어씁니다.
            textEditingController.text = result.recognizedWords + " ";
          }
        });
      },
      listenFor: const Duration(minutes: 1), // 최대 1분 동안 음성 인식을 수행합니다.
      pauseFor: const Duration(seconds: 10), // 사용자가 말을 멈춘 후 10초 동안 대기합니다.
    );
    setState(() => isRecording = true);
  }


  void stopListening() {
    speechToText.stop();
    setState(() => isRecording = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('실시간 발음 테스트'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25, 20, 25, 100),
              child: TextField(
                controller: textEditingController,
                expands: true,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: '음성 인식을 통해 발음이 여기에 표시됩니다...',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Ink(
                  decoration: BoxDecoration(
                    color: isRecording ? Colors.red : Colors.blue,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(40),
                    onTap: toggleRecording,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Icon(
                        isRecording ? Icons.stop : Icons.mic,
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
      ),
    );
  }
}