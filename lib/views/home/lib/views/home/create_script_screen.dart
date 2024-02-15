import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class CreateScriptPage extends StatefulWidget {
  @override
  _CreateScriptPageState createState() => _CreateScriptPageState();
}

class _CreateScriptPageState extends State<CreateScriptPage> {
  bool isCompleted = false;
  bool isRecording = false;
  TextEditingController textEditingController = TextEditingController();
  stt.SpeechToText speechToText = stt.SpeechToText();
  String lastWords = ""; // 인식된 마지막 단어들을 저장할 변수

  @override
  void initState() {
    super.initState();
    requestPermission();
    speechToText.initialize();
    initializeSpeech();
  }

  void initializeSpeech() async {
    bool available = await speechToText.initialize(
        onError: (error) => print("onError: $error"),
        onStatus: (status) => print("onStatus: $status")
    );
    if (!available) {
      print("음성 인식을 사용할 수 없습니다.");
    }
  }

  Future<void> requestPermission() async {
    var microphoneStatus = await Permission.microphone.status;
    if (!microphoneStatus.isGranted) {
      var requested = await Permission.microphone.request();
      if (!requested.isGranted) {
        // 권한 거부 메시지 출력
        print("마이크 권한이 거부되었습니다.");
        // 사용자에게 앱 설정 페이지로 이동하여 권한을 부여하도록 안내
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("마이크 권한 필요"),
            content: Text("이 기능을 사용하기 위해서는 마이크 권한이 필요합니다. 앱 설정에서 마이크 권한을 부여해주세요."),
            actions: <Widget>[
              TextButton(
                child: Text("설정으로 이동"),
                onPressed: () {
                  Navigator.of(context).pop();
                  openAppSettings(); // 앱 설정 페이지 열기
                },
              ),
              TextButton(
                child: Text("취소"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
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
    // 음성 인식이 이미 초기화되었는지 확인하고, 그렇지 않다면 초기화를 시도합니다.
    if (!speechToText.isAvailable) {
      bool available = await speechToText.initialize(onError: (error) => print(error), onStatus: (status) => print(status));
      if (!available) {
        print("The user has denied the use of speech recognition or an error occurred during initialization.");
        return;
      }
    }
    // 음성 인식을 시작합니다.
    speechToText.listen(
      onResult: (result) {
        setState(() {
          // 인식된 결과가 최종 결과인 경우에만 텍스트를 업데이트합니다.
          if (result.finalResult) {
            textEditingController.text += result.recognizedWords + " ";
          }
        });
      },
      listenFor: const Duration(minutes: 1), // 최대 30초 동안 음성 인식을 수행합니다.
      pauseFor: const Duration(seconds: 10), // 사용자가 말을 멈춘 후 5초 동안 대기합니다.
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
          title: Text('대본 생성하기'),
          centerTitle: true,
          actions: <Widget>[
            if (!isCompleted)
              TextButton(
                onPressed: () {
                  setState(() {
                    isCompleted = true;
                  });
                },
                child: Text(
                  '완료',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: isCompleted ? EdgeInsets.fromLTRB(25, 20, 25, 125) : EdgeInsets.fromLTRB(25, 20, 25, 20),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: textEditingController,
                  expands: true,
                  maxLines: null,
                  enabled: !isCompleted,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: '대본을 입력하세요...',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
            ),
            if (isCompleted)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: isRecording ? Colors.red : Colors.blue,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: toggleRecording,
                      child: Padding(
                        padding: EdgeInsets.all(25),
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
            // 인식된 음성을 화면에 표시
          ],
        ),
      ),
    );
  }
}
