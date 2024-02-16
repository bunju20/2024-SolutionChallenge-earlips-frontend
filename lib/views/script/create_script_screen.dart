import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:earlips/viewModels/script/create_script_viewmodel.dart'; // 실제 경로에 맞게 수정해주세요.

class CreateScriptPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateScriptViewModel>(
      create: (_) => CreateScriptViewModel(),
      child: Consumer<CreateScriptViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('대본으로 학습하기'),
            centerTitle: true,
            actions: <Widget>[
              TextButton(
                onPressed: model.complete,
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
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: model.writedTextController, // 수정됨
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: '대본을 입력하세요...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Text(
                      model.voicedTextController.text, // 수정됨
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: model.toggleRecording,
            child: Icon(
              model.isRecording ? Icons.stop : Icons.mic,
            ),
          ),
        ),
      ),
    );
  }
}
