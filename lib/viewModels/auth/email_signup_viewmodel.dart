import 'package:earlips/utilities/validators/auth_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailSignupViewModel extends GetxController {
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

  Future<void> registerWithEmailAndPassword() async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        // 뒤로
        Get.back();
      } on FirebaseAuthException catch (_) {
        Get.snackbar('회원가입 실패', '회원가입에 실패했습니다. 다시 시도해주세요.',
            snackPosition: SnackPosition.TOP);
      }
    }
  }
}
