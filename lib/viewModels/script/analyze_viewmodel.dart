import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON 데이터를 다루기 위해 필요
class AnalyzeViewModel with ChangeNotifier {
  List<String> userWord = [];
  List<String> userSenten = [];
  List<int> wrongWordIndexes = [];
  List<double> wrongFastIndexes = [];

  void updateData(Map<String, dynamic> data) {
    userWord = List<String>.from(data['user_word'] as List<dynamic>? ?? []);
    userSenten = List<String>.from(data['user_sentence'] as List<dynamic>? ?? []);
    wrongWordIndexes = List<int>.from(data['wrong'] as List<dynamic>? ?? []);
    wrongFastIndexes = (data['speed'] as List<dynamic>? ?? []).map((e) {

      if (e is double) {
        return e;
      } else if (e is int) {
        return e.toDouble();
      } else {
        // 로그 출력 또는 오류 처리
        print("Warning: Invalid type in 'speed' list, defaulting to 0.0");
        return 0.0; // 기본값
      }
    }).toList();
    notifyListeners(); // 데이터가 업데이트되면 리스너들에게 알립니다.
  }
}
