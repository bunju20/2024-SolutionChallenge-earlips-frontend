import 'package:cloud_firestore/cloud_firestore.dart';
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

  String extractNickname(String email) {
    if (email.contains('@')) {
      return email.substring(0, email.indexOf('@'));
    } else {
      return email;
    }
  }

  // Password Validator
  String? passwordValidator(String? value) {
    return AuthValidators.passwordValidator(value);
  }

  Future<void> registerWithEmailAndPassword() async {
    if (formKey.currentState!.validate()) {
      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        final userRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid);

        // 사용자 데이터
        final userData = {
          'uid': userCredential.user!.uid,
          'systemLanguage': 'kr',
          'learningLanguage': 'kr',
          'nickname': extractNickname(emailController.text.trim()),
          'email': emailController.text.trim(),
        };
        // Firestore에 사용자 데이터 저장
        await userRef.set(userData);

        // 뒤로
        Get.back();
      } on FirebaseAuthException catch (_) {
        Get.snackbar(
          "signup_fail_title".tr,
          "signup_fail_content".tr,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }
}
