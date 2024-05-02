import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

class LearningSessionScreenViewModel extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxBool isLoading = true.obs; // 로딩 상태 관리
  final RxList<Paragraph> paragraphs = <Paragraph>[].obs; // Paragraph 객체 리스트

  // Firestore에서 paragraphs 컬렉션의 데이터를 가져오는 함수

  Future<void> fetchParagraphsScript() async {
    final uid = _auth.currentUser?.uid; // 사용자 UID 가져오기
    try {
      isLoading.value = true; // 로딩 시작
      final QuerySnapshot paragraphSnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('paragraph') // 사용자의 paragraph 컬렉션에 접근
          .orderBy('dateFormat', descending: true) // DateTime 기준으로 정렬
          .get();

      final List<Paragraph> fetchedParagraphs =
          paragraphSnapshot.docs.map((doc) {
        // doc.data() 호출 결과를 Map<String, dynamic>으로 타입 캐스팅
        final data = doc.data() as Map<String, dynamic>?;
        // Null-safety를 고려하여, 필드에 접근하기 전에 null 체크
        final title = data?['title'] as String? ?? ''; // title이 없으면 빈 문자열 할당
        final text = data?['text'] as String? ?? ''; // text가 없으면 빈 문자열 할당
        // dateFormat 필드를 DateTime으로 변환
        final dateFormat = data?['dateFormat']?.toDate() ??
            DateTime.now(); // dateFormat이 없으면 현재 시간 할당

        // DateTime 객체를 원하는 문자열 형식으로 변환
        final formattedDate = DateFormat('yyyy/MM/dd').format(dateFormat);
        String timeFormat = DateFormat('h:mm a').format(dateFormat);
        return Paragraph(
            title: title, text: text, dateFormat: formattedDate.toString(), timeFormat: timeFormat);
      }).toList();

      paragraphs.value = fetchedParagraphs; // 상태 업데이트
    } catch (_) {
    } finally {
      isLoading.value =false; // 로딩 종료
    }
  }


  Future<void> fetchParagraphsStudy() async {
    try {
      isLoading.value = true; // 로딩 시작
      final QuerySnapshot paragraphSnapshot = await _firestore
          .collection('paragraph') // paragraph 컬렉션에 접근
          .limit(5) // 예제로 5개의 문서만 가져오기
          .get();

      final List<Paragraph> fetchedParagraphs =
      paragraphSnapshot.docs.map((doc) {
        // doc.data() 호출 결과를 Map<String, dynamic>으로 타입 캐스팅
        final data = doc.data() as Map<String, dynamic>?;
        // Null-safety를 고려하여, 필드에 접근하기 전에 null 체크
        final title = data?['title'] as String? ?? ''; // title이 없으면 빈 문자열 할당
        final text = data?['text'] as String? ?? ''; // text가 없으면 빈 문자열 할당
        final dateFormat = data?['dateFormat']?.toDate() ?? "Example";

        String timeFormat = DateFormat('h:mm a').format(DateTime.now());

        return Paragraph(title: title, text: text, dateFormat: dateFormat.toString(), timeFormat: timeFormat);
      }).toList();

      paragraphs.value = fetchedParagraphs; // 상태 업데이트
    } catch (_) {
    } finally {
      isLoading.value = false; // 로딩 종료
    }
  }

}

// Firestore 문서로부터 생성되는 Paragraph 모델
class Paragraph {
  final String title;
  final String text;
  final String ?dateFormat;
  final String ?timeFormat;
  Paragraph(
      {required this.title, required this.text, this.dateFormat, this.timeFormat});
}
