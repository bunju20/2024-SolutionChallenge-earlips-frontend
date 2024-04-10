import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:earlips/viewModels/script/create_script_viewmodel.dart';
import 'package:get/get.dart';

class CreateScriptPage extends StatelessWidget {
  final String? title; // 선택적으로 제목을 받음
  final String? text; // 선택적으로 텍스트를 받음

  const CreateScriptPage({super.key, this.title, this.text});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateScriptViewModel>(
      create: (_) => CreateScriptViewModel(),
      child: Consumer<CreateScriptViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(
              title ?? 'home_script_subtitle'.tr, // 제목이 제공되면 사용, 아니면 기본값
            ),
            centerTitle: true,
            actions: <Widget>[
              TextButton(
                onPressed: model.complete,
                child: Text(
                  'appbar_done'.tr,
                  style: const TextStyle(
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
                      child: text != null
                          ? // 텍스트가 제공되면 이를 사용하여 Container를 구성
                      Container(
                        width: Get.width - 40,
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                        ),
                        child: Text(
                          text!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      )
                          : // 텍스트가 제공되지 않으면 기본 TextField를 사용
                      TextField(
                        controller: model.writedTextController,
                        expands: true,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'live_script_hint'.tr,
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
