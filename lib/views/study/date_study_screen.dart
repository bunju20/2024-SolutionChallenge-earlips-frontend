import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ViewModel import 경로는 실제 프로젝트 구조에 따라 달라질 수 있습니다.
import 'package:earlips/viewModels/study/date_study_screen_viewmodel.dart';

class DateStudyScreen extends StatelessWidget {
  final DateTime date;
  DateStudyScreen({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = DateStudyViewModel(date: date);
    final sessions = viewModel.getSessions();

    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('yyyy년 MM월 dd일').format(date)), // 동적으로 날짜를 표시
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
                    child: _SmallCard(name: session.type)), // 세션 유형을 표시
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  title: Container(
                    alignment: Alignment.center,
                    child: Text(
                      session.text, // 세션과 관련된 텍스트를 표시
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onTap: () {
                    // TODO: 세부 대본 학습 페이지로 이동하도록 구현
                  },
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20),
      ),
    );
  }
}

class _SmallCard extends StatelessWidget {
  final String name;

  const _SmallCard({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Color(0xFF1FA9DC),
      ),
      alignment: Alignment.center,
      width: 50,
      height: 20,
      child: Text(
        name,
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