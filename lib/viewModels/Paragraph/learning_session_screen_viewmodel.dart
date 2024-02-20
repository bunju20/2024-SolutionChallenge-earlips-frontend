import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;


class LearningSessionScreenViewModel extends GetxController {
  final RxBool isLoading = false.obs; // 로딩 상태 관리
  final RxList<Paragraph> paragraphs = <Paragraph>[].obs; // Paragraph 객체 리스트

  // Firestore에서 paragraphs 컬렉션의 데이터를 가져오는 함수
  Future<void> fetchParagraphs() async {
    try {
      isLoading(true); // 로딩 시작
      final QuerySnapshot paragraphSnapshot = await _firestore
          .collection('paragraphs')
          .limit(5) // 예제로 5개의 문서만 가져오기
          .get();

      final List<Paragraph> fetchedParagraphs = paragraphSnapshot.docs
          .map((doc) => Paragraph(
        title: doc['title'], // 문서의 title 필드
        text: doc['text'], // 문서의 text 필드
      ))
          .toList();

      paragraphs.value = fetchedParagraphs; // 상태 업데이트
    } catch (e) {
      print("Error fetching paragraphs: $e"); // 오류 처리
    } finally {
      isLoading(false); // 로딩 종료
    }
  }
}

// Firestore 문서로부터 생성되는 Paragraph 모델
class Paragraph {
  final String title;
  final String text;

  Paragraph({required this.title, required this.text});
}
