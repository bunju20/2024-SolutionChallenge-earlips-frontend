import 'package:earlips/services/auth/auth_service.dart';
import 'package:earlips/views/auth/auth_card_widget.dart';
import 'package:earlips/views/auth/email_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  // AuthService 인스턴스 생성
  final AuthService _authService = AuthService();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_screen.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AuthCard(
                iconPath: "assets/icons/google.svg",
                label: "구글 계정으로 로그인",
                onTap: () => _authService.signInWithGoogle(),
              ),
              AuthCard(
                iconPath: "assets/icons/mailbox.svg",
                label: "이메일로 로그인",
                onTap: () => Get.to(() => const EmailLoginScreen()),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
