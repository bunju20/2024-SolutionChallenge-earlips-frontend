import 'package:flutter/foundation.dart';

class AnalyzeViewModel with ChangeNotifier {
  List<String> userWord = [];
  List<String> userSenten = [];
  List<int> wrongWordIndexes = [];
  List<double> wrongFastIndexes = [];

  void updateData(Map<String, dynamic> data) {
    userWord = List<String>.from(data['user_word'] as List<dynamic>? ?? []);
    userSenten =
        List<String>.from(data['user_sentence'] as List<dynamic>? ?? []);
    wrongWordIndexes = List<int>.from(data['wrong'] as List<dynamic>? ?? []);
    wrongFastIndexes = (data['speed'] as List<dynamic>? ?? []).map((e) {
      if (e is double) {
        return e;
      } else if (e is int) {
        return e.toDouble();
      } else {
        return 0.0; // 기본값
      }
    }).toList();
    notifyListeners(); // 데이터가 업데이트되면 리스너들에게 알립니다.
  }
}
