// auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

      // 홈화면으로 이동
      Get.offAllNamed('/');
    } catch (error) {
      // 에러 발생시 에러 메시지 출력
      Get.snackbar(
        "구글 로그인 실패",
        error.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
