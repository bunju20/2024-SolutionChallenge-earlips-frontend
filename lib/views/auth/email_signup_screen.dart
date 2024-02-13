import 'package:earlips/viewModels/auth/email_signup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailSignupScreen extends StatelessWidget {
  const EmailSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 뷰 모델을 가져옴
    final controller = Get.put(EmailSignupViewModel());

    return Scaffold(
      appBar: AppBar(
        title: const Text("이메일 회원가입"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          // 키 값을 ViewModel에서 가져옴
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                // 이메일 메소드 호출
                controller: controller.emailController,
                decoration: const InputDecoration(hintText: '이메일'),
                validator: (value) => controller.emailValidator(value),
              ),
              TextFormField(
                // 비밀번호 메소드 호출
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: '비밀번호'),
                validator: (value) => controller.passwordValidator(value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                // 회원가입 메소드 호출
                onPressed: controller.registerWithEmailAndPassword,
                child: const Text('회원 가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
