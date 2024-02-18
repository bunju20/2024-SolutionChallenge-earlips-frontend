// userViewmodel
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());

    if (uid != null) getUserData();
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
