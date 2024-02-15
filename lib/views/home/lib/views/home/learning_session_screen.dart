import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'create_script_screen.dart';

class LearningSession {
  final String title;
  final DateTime createdDate;

  LearningSession({required this.title, required this.createdDate});
}

// Todo: 일단 여기서는 StatelessWidget을 사용했는데, Stateful로 해야하는지?
class LearningSessionScreen extends StatelessWidget {
  // Todo: 나중에 더미데이터 바꾸기 -> viewModels로 로직 변경
  final List<LearningSession> sessions = [
    LearningSession(title: '대본 1', createdDate: DateTime(2024, 2, 11)),
    LearningSession(title: '대본 2', createdDate: DateTime(2024, 2, 11)),
    LearningSession(title: '대본 3', createdDate: DateTime(2024, 2, 11)),
    LearningSession(title: '대본 4', createdDate: DateTime(2024, 2, 11)),
    LearningSession(title: '대본 5', createdDate: DateTime(2024, 2, 11)),
    LearningSession(title: '대본 6', createdDate: DateTime(2024, 2, 11)),
    LearningSession(title: '대본 7', createdDate: DateTime(2024, 2, 11)),
    LearningSession(title: '대본 8', createdDate: DateTime(2024, 2, 11)),
    LearningSession(title: '대본 9', createdDate: DateTime(2024, 2, 11)),
    LearningSession(title: '대본 10', createdDate: DateTime(2024, 2, 11)),
  ];

  LearningSessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('대본으로 학습하기'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          var session = sessions[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                // 그림자 설정
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(20),
              title: Text(
                session.title,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(DateFormat('yyyy/MM/dd').format(session.createdDate)),
              ),
              onTap: () {
                // Todo: 세부 대본 학습 페이지로 이동하도록 구현
              },
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20), // 카드들 사이의 간격 조정
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CreateScriptPage()),
        child: const Icon(Icons.add),
      ),
    );
  }
}