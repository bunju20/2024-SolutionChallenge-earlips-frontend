// email_login_viewmodel.dart

import 'package:earlips/utilities/validators/auth_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailLoginViewModel extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        // 로그인 성공시 홈화면으로 이동
        Get.offAllNamed('/');
      } on FirebaseAuthException catch (_) {
        Get.snackbar('로그인 실패', "로그인에 실패했습니다. 다시 시도해주세요.",
            snackPosition: SnackPosition.TOP);
      }
    }
  }
}
