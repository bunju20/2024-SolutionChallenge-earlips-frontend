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
        title: const Text("이메일 로그인"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          // 키 값을 ViewModel에서 가져옴
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(hintText: '이메일'),
                validator: (value) => controller.emailValidator(value),
              ),
              TextFormField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: '비밀번호'),
                validator: (value) => controller.passwordValidator(value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                // 로그인 메소드 호출
                onPressed: controller.signInWithEmailAndPassword,
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              // 회원가입 화면으로 이동
              TextButton(
                onPressed: () => Get.to(() => const EmailSignupScreen()),
                child: const Text("회원가입 하러가기"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
