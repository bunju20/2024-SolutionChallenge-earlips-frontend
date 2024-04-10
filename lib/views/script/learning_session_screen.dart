import 'package:earlips/views/base/default_back_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:earlips/views/script/widget/small_card.dart';
import 'package:earlips/views/script/create_script_screen.dart';
import 'package:earlips/viewModels/script/learning_session_screen_viewmodel.dart';
import 'package:intl/intl.dart'; // DateFormat을 사용하기 위해 추가

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
    // 로그인 상태를 확인하고, 로그인 상태에 따라 데이터를 가져오는 로직을 여기에 배치
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is signed in
        viewModel.fetchParagraphs(); // 로그인한 사용자의 데이터를 가져옵니다.
      } else {
        // No user is signed in
        // 로그인하지 않은 사용자에 대한 처리는 필요하지 않을 수 있습니다.
        // 필요하다면, 여기에 로그인하지 않은 사용자를 위한 초기화 코드를 추가합니다.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(
          title: 'home_script_title'.tr,
        ),
      ),
      body: Obx(() {
        if (viewModel.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final bool isLoggedIn = snapshot.hasData;
              if (!isLoggedIn) {
                // 로그인하지 않았을 경우 더미 데이터로 UI 구성
                final dummyDate =
                    DateFormat('yyyy/MM/dd').format(DateTime.now());
                final dummyParagraph = Paragraph(
                  title: "로그인을 하면 생성한 대본이 기록됩니다!",
                  text: "로그인을 하면 생성한 대본이 저장되어 대본을 토대로 학습할 수 있습니다!",
                  dateFormat: dummyDate,
                );
                return Container(
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    height: Get.height * 0.15,
                    width: Get.width * 0.9,
                    child: _buildParagraphContainer(dummyParagraph));
              } else {
                // 로그인 했을 경우의 UI 구성
                return Container(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
                    itemCount: viewModel.paragraphs.length,
                    itemBuilder: (context, index) {
                      var paragraph = viewModel.paragraphs[index];
                      return _buildParagraphContainer(paragraph);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                  ),
                );
              }
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const CreateScriptPage()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildParagraphContainer(Paragraph paragraph) {
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
            contentPadding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            title: Container(
              alignment: Alignment.center,
              child: Text(
                paragraph.title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {
              Get.to(() => CreateScriptPage(
                  title: paragraph.title, text: paragraph.text));
            },
          ),
        ],
      ),
    );
  }
}
