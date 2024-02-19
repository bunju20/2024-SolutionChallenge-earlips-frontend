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
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 0.1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SmallCard(name: DateFormat('yyyy/MM/dd').format(session.createdDate)),
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                    title: Container(
                      alignment: Alignment.center,
                      child: Text(
                        session.title,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () {
                      // Todo: 세부 대본 학습 페이지로 이동하도록 구현
                    },
                  ),
                ],
              ),
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


class _SmallCard extends StatelessWidget {
  final String name;

  const _SmallCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, top: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: const Color(0xFF1FA9DC),
      ),
      alignment: Alignment.center,
      width: Get.height * 0.1,
      height: 24,
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
