import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:earlips/viewModels/script/create_script_viewmodel.dart';
import 'package:get/get.dart';

class CreateScriptPage extends StatelessWidget {
  final String? title;
  final String? text;

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
                  _TopBoxs(number: text == null ? 1 : 2,),
                  _ScriptBox(text: text),
                  model.isRecording ? Image.asset(
                    "assets/images/sound_wave.gif" ,
                    width: 180,
                    height: 90,
                  ) : Container(
                    width: 180,
                    height: 90,
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 40.0),
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

            ],
          ),
        ),
      ),
    );
  }
}


class _TopBoxs extends StatelessWidget {
  const _TopBoxs({super.key, this.number});
  final int? number;

  @override
  Widget build(BuildContext context) {
    Color leftColor = number == 1 ? Color(0xFF62ACDE) : Color(0xFFE8E8E8);
    Color rightColor = number == 2 ? Color(0xFF62ACDE) : Color(0xFFE8E8E8);
    Color leftTextColor = number == 1 ? Colors.white : Colors.white; // 오른쪽 텍스트 색깔을 다르게 설정
    Color rightTextColor = number == 2 ? Colors.white : Colors.white;

    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: leftColor,
              borderRadius: BorderRadius.circular(7.0),
            ),
            height: 35,
            width: Get.width * 0.5 - 24,
            child: Text("대본 생성 및 녹음", style: TextStyle(
              color: leftTextColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),),
          ),
          SizedBox(width: 8),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: rightColor,
              borderRadius: BorderRadius.circular(7.0),
            ),
            height: 35,
            width: Get.width * 0.5 - 24,
            child: Text("대본 기반 녹음", style: TextStyle(
              color: rightTextColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),),
          ),
        ],
      ),
    );
  }
}

class _ScriptBox extends StatelessWidget {
  const _ScriptBox({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CreateScriptViewModel>();
    return Expanded(
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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            text!,
            style: const TextStyle(fontSize: 16),
          ),
        )
            : // 텍스트가 제공되지 않으면 기본 TextField를 사용
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          margin: const EdgeInsets.all(10.0),
          width: Get.width - 40,
          child: TextField(
            controller: model.writedTextController,
            expands: true,
            maxLines: null,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15.0),
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
    );
  }
}


