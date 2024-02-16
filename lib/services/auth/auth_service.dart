// auth_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // 로그인 상태 확인
  Future<bool> isLoggedIn() async {
    final String? uid = await _storage.read(key: 'uid');
    return uid != null && uid.isNotEmpty;
  }

  String extractNickname(String email) {
    if (email.contains('@')) {
      return email.substring(0, email.indexOf('@'));
    } else {
      return email;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // 구글 로그인
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // 구글 로그인 인증 정보
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // 구글 로그인 자격 증명
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // 구글 로그인 성공시 UserCredential 반환
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // 처음 로그인인지 확인
      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

      // 처음 로그인 시 Firestore 설정
      if (isNewUser) {
        final userRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid);

        // 사용자 데이터
        final userData = {
          'systemLanguage': 'kr',
          'learningLanguage': 'kr',
          'nickname': extractNickname(googleUser!.email), // @ 앞까지만 추출
          'email': googleUser.email,
        };

        // Firestore에 사용자 데이터 저장
        await userRef.set(userData);
      }

      // uid 저장
      await _storage.write(key: 'uid', value: _auth.currentUser?.uid);

      // 홈화면으로 이동
      Get.offAllNamed('/');
    } catch (error) {
      // 에러 발생시 에러 메시지 출력
      Get.snackbar(
        "구글 로그인 실패",
        "구글 로그인에 실패했습니다. 다시 시도해주세요.",
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    await _auth.signOut();
    await _storage.delete(key: 'uid');
  }

  // 회원 탈퇴
  Future<void> withdraw() async {
    try {
      // 현재 로그인된 사용자 정보 가져오기
      final User? user = _auth.currentUser;

      // 사용자 계정 삭제
      await user?.delete();

      // 로그인 정보 삭제
      await _storage.delete(key: 'uid');
    } catch (error) {
      // 에러 발생시 에러 메시지 출력
      Get.snackbar(
        "회원 탈퇴 실패",
        "회원 탈퇴에 실패했습니다. 다시 시도해주세요.",
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
