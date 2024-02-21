// email_login_viewmodel.dart

import 'package:earlips/utilities/validators/auth_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class EmailLoginViewModel extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Email Validator
  String? emailValidator(String? value) {
    return AuthValidators.emailValidator(value);
  }

  // Password Validator
  String? passwordValidator(String? value) {
    return AuthValidators.passwordValidator(value);
  }

  // 로그인 메소드
  Future<void> signInWithEmailAndPassword() async {
    if (formKey.currentState!.validate()) {
      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // 로그인 성공시 uid를 저장
        final String uid = userCredential.user!.uid;
        await _storage.write(key: 'uid', value: uid);

        // 로그인 성공시 홈화면으로 이동
        Get.offAllNamed('/');
      } on FirebaseAuthException catch (_) {
        Get.snackbar(
          'login_fail_snackar_title'.tr,
          'login_fail_snackar_message'.tr,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }
}
