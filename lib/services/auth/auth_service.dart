// auth_service.dart

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
      await _auth.signInWithCredential(credential);

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
}
