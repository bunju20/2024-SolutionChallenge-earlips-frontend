import 'package:flutter/foundation.dart';

class AnalyzeViewModel with ChangeNotifier {

  final List<String> userWord = [
    "가", "나", "다", "어쩌구", "저쩌구", "입니다", "나는", "매일", "조깅을", "합니다",
    "플러터로", "앱", "개발을", "배우고", "있어요", "이것은", "더미", "텍스트입니다",
    "데이터를", "시각화하는", "것은", "중요합니다"
  ];
  final List<String> userSenten = [
    "가 나 다 어쩌구 저쩌구 입니다.",
    "나는 매일 조깅을 합니다.",
    "플러터로 앱 개발을 배우고 있어요.",
    "이것은 더미 텍스트입니다.",
    "데이터를 시각화하는 것은 중요합니다.",
  ];
  final List<int> wrongWordIndexes = [2, 14]; // "다", "앱"을 가리킴
  final List<int> wrongFastIndexes = [1, 3]; // 두 번째와 네 번째 문장을 가리킴

  // ViewModel 초기화
  AnalyzeViewModel() {
    // 필요한 초기화 로직 추가
  }

// 여기에 필요한 기능을 추가하세요.
}
