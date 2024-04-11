// userViewmodel
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// **UserViewModel**
/// [FirebaseAuth]와 [FirebaseFirestore]를 사용하여 사용자 정보를 가져오는 뷰 모델
/// 사용자 정보를 가져오는 동안 로딩 상태를 관리하고, 사용자 정보를 저장하는 변수를 관리
/// 사용자 정보를 가져오는 동안 에러가 발생하면 에러 처리 로직을 추가할 수 있음
/// 사용자 정보를 가져오는 동안 로딩 상태를 관리하고, 사용자 정보를 저장하는 변수를 관리
/// 사용자 정보를 가져오는 동안 에러가 발생하면 에러 처리 로직을 추가할 수 있음
class UserViewModel extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = const FlutterSecureStorage(); // Instance for secure storage
  var isLoading = true.obs; // 로딩 상태를 관리하는 Observable 변수 추가

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
  void onInit() {
    super.onInit();
    fetchAndSetGraphData().then((_) {
      isLoading.value = false; // fetchAndSetGraphData가 완료되면 로딩 상태를 false로 변경
    }).catchError((error) {
      isLoading.value = false; // 에러 발생 시에도 로딩 상태를 false로 변경
      // 에러 처리 로직 추가 가능
    });
    _firebaseUser.bindStream(_auth.authStateChanges());

    if (uid != null) getUserData();
  }

  Future<void> fetchAndSetGraphData() async {
    final data = await _dataFetcher.fetchGraphData();
    flSpots.value = data;
    maxYValue.value = _dataFetcher.maxYValue;
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
  Future<void> updateLanguageSettings(value) async {
    //value
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
        if (value == '한국어') {
          Get.updateLocale(const Locale('ko', 'KR'));
        } else {
          Get.updateLocale(const Locale('en', 'US'));
        }

        Get.snackbar(
          'language_setting_snackbar_title'.tr,
          "language_setting_snackbar_content".tr,
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
          "language_setting_snackbar_title".tr,
          "language_setting_snackbar_content".tr,
          snackPosition: SnackPosition.TOP,
        );
        if (value == '한국어') {
          Get.updateLocale(const Locale('ko', 'KR'));
        } else {
          Get.updateLocale(const Locale('en', 'US'));
        }
      }
    } catch (e) {
      Get.snackbar(
        "language_setting_snackbar_fail_title".tr,
        "language_setting_snackbar_fail_content".tr,
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
