import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class LearningSession {
  final String title;
  final DateTime createdDate;

  LearningSession({required this.title, required this.createdDate});
}

class DateStudyScreen extends StatelessWidget {
  final DateTime date;
  DateStudyScreen({Key? key, required this.date}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2024년 02월 18일'),
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
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 20.0, top: 16.0),
                    child: _SmallCard(name: '대본')),
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
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20), // 카드들 사이의 간격 조정
      ),
    );
  }
}

class _SmallCard extends StatelessWidget {
  final String name;
  const _SmallCard({super.key,required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Color(0xFF1FA9DC),
      ),
      //왼쪽에 붙게
      alignment: Alignment.center,
      width: 50,
      height:20,
      child: Text(name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Pretendard-Bold',
          fontWeight: FontWeight.bold,
        ),
    ),
    );
  }
}
