import 'package:earlips/views/word/widget/blue_back_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:earlips/views/script/widget/small_card.dart';
import 'package:earlips/views/script/create_script_screen.dart'; //대본생성
import 'package:earlips/views/script/user_script_screen.dart'; //문단교정 페이지랑 비슷함.
import 'package:earlips/viewModels/script/learning_session_screen_viewmodel.dart';


class LearningSessionScreen extends StatefulWidget {
  LearningSessionScreen({Key? key}) : super(key: key);

  @override
  State<LearningSessionScreen> createState() => _LearningSessionScreenState();
}

class _LearningSessionScreenState extends State<LearningSessionScreen> {
  final viewModel = Get.put(
      LearningSessionScreenViewModel()); // ViewModel 인스턴스 생성

  @override
  void initState() {
    super.initState();
    viewModel.fetchParagraphs(); // 화면이 로드될 때 Firestore에서 데이터 가져오기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('대본으로 학습하기'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Obx(() {
        if (viewModel.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
            itemCount: viewModel.paragraphs.length,
            itemBuilder: (context, index) {
              var paragraph = viewModel.paragraphs[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 0.1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 10.0, top: 10.0),
                      child: SmallCard(text: paragraph.dateFormat),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 30),
                      title: Text(
                        paragraph.title,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        // title과 text만 다음 페이지로 전달
                        Get.to(() =>
                            UserScriptScreen( // 누르면 가는곳, UserScriptScreen
                                title: paragraph.title, text: paragraph.text));
                      },
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 20),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CreateScriptPage()),
        child: const Icon(Icons.add),
      ),
    );
  }
}


