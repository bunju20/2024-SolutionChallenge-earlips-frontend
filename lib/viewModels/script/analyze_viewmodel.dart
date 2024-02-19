import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON 데이터를 다루기 위해 필요

class AnalyzeViewModel with ChangeNotifier {
  List<String> userWord = [];
  List<String> userSenten = [];
  List<int> wrongWordIndexes = [];
  List<double> wrongFastIndexes = [];

  // 비동기 데이터 로딩 함수는 그대로 유지
  Future<void> fetchDataFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        updateUserLists(data);
      } else {
        print("Failed to load data");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void updateUserLists(Map<String, dynamic> data) {
    userWord = List<String>.from(data['user_word']);
    userSenten = List<String>.from(data['user_sentence']);
    wrongWordIndexes = List<int>.from(data['wrong']);
    wrongFastIndexes = List<double>.from(data['speed'].map((x) => x.toDouble()));
    notifyListeners();
  }
}
