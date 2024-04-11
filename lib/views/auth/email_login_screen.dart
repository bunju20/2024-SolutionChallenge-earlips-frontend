import 'package:earlips/viewModels/auth/email_login_viewmodel.dart';
import 'package:earlips/views/auth/email_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailLoginScreen extends StatelessWidget {
  const EmailLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 이메일 로그인 뷰 모델을 가져옴
    final controller = Get.put(EmailLoginViewModel());

    return Scaffold(
      appBar: AppBar(
        title: Text("email_login_2".tr),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            // 키 값을 ViewModel에서 가져옴
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(hintText: 'email'.tr),
                  validator: (value) => controller.emailValidator(value),
                ),
                TextFormField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'password'.tr),
                  validator: (value) => controller.passwordValidator(value),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  // 로그인 메소드 호출
                  onPressed: controller.signInWithEmailAndPassword,
                  child: Text('login'.tr),
                ),
                const SizedBox(height: 10),
                // 회원가입 화면으로 이동
                TextButton(
                  onPressed: () => Get.to(() => const EmailSignupScreen()),
                  child: Text("go_signup".tr),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
