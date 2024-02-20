import 'package:earlips/utilities/style/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:earlips/viewModels/script/create_script_viewmodel.dart';
import 'package:get/get.dart';

class CreateScriptPage extends StatelessWidget {
  final String title;
  final String text;

  const CreateScriptPage({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateScriptViewModel>(
      create: (_) => CreateScriptViewModel(),
      child: Consumer<CreateScriptViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
            actions: <Widget>[
              TextButton(
                onPressed: model.complete,
                child: const Text(
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
            // Stack 위젯을 사용하여 Positioned를 올바르게 배치합니다.
            children: [
              Column(
                // 기존의 Column 구조를 Stack 내에 배치합니다.
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        text,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 20, 25, 100),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        width: Get.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            model.voicedTextController.text,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                // Positioned 위젯으로 사용자 정의 FloatingActionButton을 배치합니다.
                bottom: 20,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Ink(
                    decoration: BoxDecoration(
                      color: model.isRecording ? Colors.red : Colors.blue,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: model.toggleRecording,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Icon(
                          model.isRecording ? Icons.stop : Icons.mic,
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
      ),
    );
  }
}
