import 'package:earlips/viewModels/Paragraph/learning_session_screen_viewmodel.dart';
import 'package:earlips/views/word/widget/blue_back_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:earlips/views/paragraph/create_script_screen.dart';

class LearningSessionScreen extends StatefulWidget {
  const LearningSessionScreen({super.key});

  @override
  State<LearningSessionScreen> createState() => _LearningSessionScreenState();
}

class _LearningSessionScreenState extends State<LearningSessionScreen> {
  final viewModel =
      Get.put(LearningSessionScreenViewModel()); // ViewModel 인스턴스 생성

  @override
  void initState() {
    super.initState();
    viewModel.fetchParagraphs(); // 화면이 로드될 때 Firestore에서 데이터 가져오기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlueBackAppbar(title: "study_main_title_5".tr),
      ),
      body: Obx(() {
        if (viewModel.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
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
                child: ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  title: Text(
                    paragraph.title,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    // title과 text만 다음 페이지로 전달
                    Get.to(() => CreateScriptPage(
                        title: paragraph.title, text: paragraph.text));
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 20),
          );
        }
      }),
    );
  }
}
