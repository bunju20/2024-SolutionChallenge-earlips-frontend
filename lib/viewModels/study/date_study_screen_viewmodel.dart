import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

/// 학습 세션 데이터 모델
/// 세션 유형, 생성 날짜, 텍스트, 인덱스를 가지고 있음
/// 세션 유형은 0: 음소, 1: 단어, 2: 문장
/// 세션 인덱스는 세션의 순서를 나타냄
class LearningSession {
  final int type; // 세션 유형 (음소, 단어, 문장)
  final String createdDate; // 세션 생성 날짜
  final String text; // 세션과 관련된 텍스트
  final int index; // 세션 인덱스

  LearningSession(
      {required this.type,
      required this.createdDate,
      required this.text,
      required this.index});
}

/// 날짜별 학습 세션 데이터를 가져오는 뷰 모델
/// 파이어스토어에서 날짜별 학습 세션 데이터를 가져옴
/// 세션 데이터는 LearningSession 객체로 변환하여 반환
/// 세션 데이터가 없을 경우 빈 리스트를 반환
class DateStudyViewModel {
  final DateTime date;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DateStudyViewModel({required this.date});

  Future<List<LearningSession>> getSessions() async {
    // 파이어스토어에 저장된 날짜 형식에 맞게 날짜를 변환
    final uid = _auth.currentUser?.uid;

    String formattedDate = DateFormat('yyyyMMdd').format(date);
    try {
      // 해당 날짜의 daily record 문서를 가져옴
      DocumentSnapshot dailyRecordSnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('daily_records')
          .doc(formattedDate)
          .get();

      if (dailyRecordSnapshot.exists) {
        // 해당 날짜의 세션 데이터를 가져옴
        List<Map<String, dynamic>> sessionsData =
            List<Map<String, dynamic>>.from(
                dailyRecordSnapshot.get('wordsList') ?? []);
        // 세션 데이터를 LearningSession 객체로 변환
        List<LearningSession> sessions = sessionsData.map((session) {
          return LearningSession(
            type: session['type'],
            createdDate: formattedDate,
            text: session['word'],
            index: session['index'],
          );
        }).toList();

        return sessions;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }
}
