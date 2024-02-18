// userViewmodel
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class UserViewModel extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = const FlutterSecureStorage(); // Instance for secure storage

  // final List<WordCard> wordList = [
  //   WordCard(
  //       id: 1,
  //       word: "강",
  //       speaker: "가-앙",
  //       video: "https://www.youtube.com/watch?v=OzHrIz-wMLA"),
  //   WordCard(
  //       id: 2,
  //       word: "서",
  //       speaker: "가-앙",
  //       video: "https://www.youtube.com/watch?v=OzHrIz-wMLA"),
  //   WordCard(
  //       id: 3,
  //       word: "희",
  //       speaker: "가-앙",
  //       video: "https://www.youtube.com/watch?v=OzHrIz-wMLA"),
  //   WordCard(
  //       id: 4,
  //       word: "찬",
  //       speaker: "차-안",
  //       video: "https://www.youtube.com/watch?v=OzHrIz-wMLA"),
  //   WordCard(
  //       id: 5,
  //       word: "캬",
  //       speaker: "캬",
  //       video: "https://www.youtube.com/watch?v=OzHrIz-wMLA"),
  // ];

  //   for (final word in wordList) {
  //   await FirebaseFirestore.instance
  //       .collection('words')
  //       .doc(word.id.toString())
  //       .set(word.toMap());
  // }
  // User Profile Data
  final Rx<User?> _firebaseUser = Rx<User?>(null);
  String? get uid => _firebaseUser.value?.uid;
  final userData = Rx<Map<String, dynamic>>({});

  // Language Settings
  final systemLanguage = '한국어'.obs;
  final learningLanguage = '한국어'.obs;

  // nickname
  final nickname = ''.obs;

  //Score
  final speakingScore = 10.obs;
  final pitchScore = 10.obs;
  final circleNumber = 10.obs;
  final linialPersent = 0.1.obs;


  RxDouble maxYValue = 0.0.obs;
  RxList<FlSpot> flSpots = <FlSpot>[].obs;
  final DataFetcher _dataFetcher = DataFetcher();
  RxList<Map<DateTime, int>> graphData = RxList<Map<DateTime, int>>([]);


  @override
  @override
  void onInit() {
    super.onInit();
    updateMaxYValue();
    updateFlSpots();
    fetchAndSetGraphData();
  }
  void fetchAndSetGraphData() async {
    final data = await _dataFetcher.fetchGraphData();
    graphData.value = data;
    print(graphData);
  }

  void updateFlSpots() {
    flSpots.value = convertToFlSpots();
  }

  //데이터
  List<Map<DateTime, int>> dummyData = [
    {DateTime.now().subtract(Duration(days: 29)): 3},
    {DateTime.now().subtract(Duration(days: 28)): 7},
    {DateTime.now().subtract(Duration(days: 27)): 5},
    {DateTime.now().subtract(Duration(days: 26)): 2},
    {DateTime.now().subtract(Duration(days: 25)): 8},
    {DateTime.now().subtract(Duration(days: 24)): 4},
    {DateTime.now().subtract(Duration(days: 23)): 6},
    {DateTime.now().subtract(Duration(days: 22)): 9},
    {DateTime.now().subtract(Duration(days: 21)): 1},
    {DateTime.now().subtract(Duration(days: 20)): 10},
    {DateTime.now().subtract(Duration(days: 19)): 3},
    {DateTime.now().subtract(Duration(days: 18)): 7},
    {DateTime.now().subtract(Duration(days: 17)): 5},
    {DateTime.now().subtract(Duration(days: 16)): 2},
    {DateTime.now().subtract(Duration(days: 15)): 8},
    {DateTime.now().subtract(Duration(days: 14)): 4},
    {DateTime.now().subtract(Duration(days: 13)): 6},
    {DateTime.now().subtract(Duration(days: 12)): 9},
    {DateTime.now().subtract(Duration(days: 11)): 1},
    {DateTime.now().subtract(Duration(days: 10)): 0},
    {DateTime.now().subtract(Duration(days: 9)): 4},
    {DateTime.now().subtract(Duration(days: 8)): 7},
    {DateTime.now().subtract(Duration(days: 7)): 5},
    {DateTime.now().subtract(Duration(days: 6)): 2},
    {DateTime.now().subtract(Duration(days: 5)): 8},
    {DateTime.now().subtract(Duration(days: 4)): 4},
    {DateTime.now().subtract(Duration(days: 3)): 6},
    {DateTime.now().subtract(Duration(days: 2)): 9},
    {DateTime.now().subtract(Duration(days: 1)): 10},
    {DateTime.now(): 10},
  ];


  void updateMaxYValue() {
    // int maxWords = graphData.fold(0, (previousValue, element) => max(previousValue, element.values.first));
    // maxYValue.value = maxWords.toDouble();
  }

  List<FlSpot> convertToFlSpots() {
    List<FlSpot> spots = [];
    var sortedData = List<Map<DateTime, int>>.from(dummyData);
    sortedData.sort((a, b) => a.keys.first.compareTo(b.keys.first));

    if (sortedData.isNotEmpty) {
      final startDate = sortedData.first.keys.first;

      for (var entry in sortedData) {
        DateTime date = entry.keys.first;
        int value = entry.values.first;
        double x = date.difference(startDate).inDays.toDouble();
        spots.add(FlSpot(x, value.toDouble()));
      }
    }
    return spots;
  }


  Future<void> getUserData() async {
    if (uid != null) {
      // // users 컬렉션의 하위 컬렉션에 단어 완료 정보 삽입
      // for (final word in wordList) {
      //   await FirebaseFirestore.instance
      //       .collection('users')
      //       .doc(uid)
      //       .collection('words')
      //       .doc(word.id.toString())
      //       .set(UserWord(wordId: word.id, isDone: false).toMap());
      // }
      final doc = await _firestore.collection('users').doc(uid).get();
      userData.value = doc.data() ?? {};
      nickname.value = userData.value['nickname'] ?? '';
      systemLanguage.value = userData.value['systemLanguage'] ?? '한국어';
      learningLanguage.value = userData.value['learningLanguage'] ?? '한국어';

      speakingScore.value = userData.value['speakingScore'] ?? 86;
      pitchScore.value = userData.value['pitchScore'] ?? 50;
      circleNumber.value = userData.value['circleNumber'] ?? 80;
      linialPersent.value = userData.value['linialPersent'] ?? 0.8;
    }
  }

  void loadLanguageSettings() async {
    String? storedSystemLanguage = await storage.read(key: 'systemLanguage');
    String? storedLearningLanguage =
        await storage.read(key: 'learningLanguage');

    if (storedSystemLanguage != null) {
      systemLanguage.value = storedSystemLanguage;
    }
    if (storedLearningLanguage != null) {
      learningLanguage.value = storedLearningLanguage;
    }
  }

// 언어 설정 업데이트
  Future<void> updateLanguageSettings() async {
    try {
      if (uid != null) {
        await _firestore.collection('users').doc(uid).update({
          'systemLanguage': systemLanguage.value,
          'learningLanguage': learningLanguage.value,
        });
        // 로컬에도 저장
        await storage.write(
          key: 'systemLanguage',
          value: systemLanguage.value,
        );
        await storage.write(
          key: 'learningLanguage',
          value: learningLanguage.value,
        );

        Get.snackbar(
          "언어 설정 변경",
          "언어 설정이 변경되었습니다.",
          snackPosition: SnackPosition.TOP,
        );
      } else {
        // 로컬에도 저장
        await storage.write(
          key: 'systemLanguage',
          value: systemLanguage.value,
        );
        await storage.write(
          key: 'learningLanguage',
          value: learningLanguage.value,
        );
        Get.snackbar(
          "언어 설정 변경",
          "언어 설정이 변경되었습니다.",
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        "언어 설정 변경 실패",
        "언어 설정을 변경하는 중 오류가 발생했습니다.",
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}



class DataFetcher {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 현재부터 30일 전까지의 데이터를 가져와서 List<Map<DateTime, int>> 형태로 반환
  Future<List<Map<DateTime, int>>> fetchGraphData() async {
    List<Map<DateTime, int>> graphData = [];
    final uid = _auth.currentUser?.uid;

    if (uid != null) {
      DateTime now = DateTime.now();
      DateTime startDate = DateTime(now.year, now.month, now.day - 30);

      for (int i = 0; i <= 30; i++) {
        DateTime currentDate = startDate.add(Duration(days: i));
        String formattedDate = DateFormat('yyyyMMdd').format(currentDate);

        var docSnapshot = await _firestore
            .collection('users')
            .doc(uid)
            .collection('records')
            .doc(formattedDate)
            .get();

        if (docSnapshot.exists) {
          Map<String, dynamic> data = docSnapshot.data()!;
          int cnt = data['cnt'] ?? 0;
          graphData.add({currentDate: cnt});
        } else {
          // 해당 날짜에 데이터가 없는 경우 cnt를 0으로 처리
          graphData.add({currentDate: 0});
        }
      }
    }

    return graphData;
  }
}
