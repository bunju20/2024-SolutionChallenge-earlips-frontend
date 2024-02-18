// userViewmodel
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  //Graph Data (날짜,해당 날짜에 학습한 단어등등의 횟수)
  final graphData = <Map<DateTime, int>>[].obs;
  final maxYValue = 0.0.obs;


  //Test용
  // 더미 데이터 생성 및 상태 업데이트 함수
  void generateAndUpdateFromDummyData() {
    final List<Map<DateTime, int>> dummyData = generateDummyData();
  }

  // 더미 데이터 생성
  List<Map<DateTime, int>> generateDummyData() {
    final List<Map<DateTime, int>> dummyData = [];
    final DateTime now = DateTime.now();
    final Random random = Random();

    for (int i = 30; i > 0; i--) {
      DateTime date = DateTime(now.year, now.month, now.day - i);
      int value = random.nextInt(10) + 1; // 1부터 10 사이의 랜덤 값
      dummyData.add({date: value});
    }

    return dummyData;
  }



  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());

    if (uid != null) getUserData();
  }

  Future<void> getUserData() async {
    if (uid != null) {
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
