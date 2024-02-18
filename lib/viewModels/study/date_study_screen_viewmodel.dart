import 'package:flutter/material.dart';

class LearningSession {
  final String type; // 세션 유형 (음소, 단어, 문장)
  final DateTime createdDate; // 세션 생성 날짜
  final String text; // 세션과 관련된 텍스트

  LearningSession({required this.type, required this.createdDate, required this.text});
}

class DateStudyViewModel {
  final DateTime date;

  DateStudyViewModel({required this.date});

  List<LearningSession> getSessions() {
    // 실제 애플리케이션에서는 여기서 날짜에 따라 데이터를 조회하거나 필터링하는 로직을 구현할 수 있습니다.
    return [
      LearningSession(type: '음소', createdDate: DateTime(2024, 2, 12), text: "가"),
      LearningSession(type: '단어', createdDate: DateTime(2024, 2, 13), text: "가다"),
      LearningSession(type: '문장', createdDate: DateTime(2024, 2, 14), text: "가다 보면 길이 있다."),
    ];
  }
}
