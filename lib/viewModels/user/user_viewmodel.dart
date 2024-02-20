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

  final flSpots = <FlSpot>[].obs;
  final DataFetcher _dataFetcher = DataFetcher();
  RxDouble maxYValue = 0.0.obs;

  @override
  @override
  void onInit() {
    super.onInit();
    fetchAndSetGraphData();
    _firebaseUser.bindStream(_auth.authStateChanges());

    if (uid != null) getUserData();
  }

  void fetchAndSetGraphData() async {
    final data = await _dataFetcher.fetchGraphData();
    flSpots.value = data;
    maxYValue.value = _dataFetcher.maxYValue;
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
      print('nickname: ${nickname.value}');
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
  double maxYValue = 0.0;

  Future<List<FlSpot>> fetchGraphData() async {
    List<FlSpot> spots = [];
    final uid = _auth.currentUser?.uid;
    if (uid == null) return spots;
    maxYValue = 0.0;

    DateTime now = DateTime.now();
    DateTime startDate = DateTime(now.year, now.month, now.day - 29);
    DateFormat formatter = DateFormat('yyyyMMdd'); // Reuse the formatter

    // Prepare a list of all dates to query
    List<Future<DocumentSnapshot>> futures = List.generate(31, (i) {
      DateTime currentDate = startDate.add(Duration(days: i));
      String formattedDate = formatter.format(currentDate);
      return _firestore
          .collection('users')
          .doc(uid)
          .collection('records')
          .doc(formattedDate)
          .get();
    });

    // Fetch all data concurrently
    List<DocumentSnapshot> snapshots = await Future.wait(futures);

    // Process the fetched data
    for (int i = 0; i < snapshots.length; i++) {
      if (snapshots[i].exists) {
        Map<String, dynamic> data = snapshots[i].data() as Map<String, dynamic>;
        double cnt = (data['cnt'] ?? 0).toDouble();
        spots.add(FlSpot(i.toDouble(), cnt));
        maxYValue = max(maxYValue, cnt.toDouble());
      } else {
        spots.add(FlSpot(i.toDouble(), 0)); // Handle missing data
      }
    }

    return spots;
  }
}
