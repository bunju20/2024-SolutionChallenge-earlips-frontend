import 'package:earlips/services/auth/auth_service.dart';
import 'package:earlips/views/auth/email_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // AuthService 인스턴스 생성
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --------------------- 구글 로그인 ---------------------
              InkWell(
                onTap: () {
                  _authService.signInWithGoogle();
                },
                child: Card(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/google.svg",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(width: 10),
                      const Text("Sign in with Google",
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // --------------------- 이메일 로그인 ---------------------
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const EmailLoginScreen());
                },
                child: const Text("이메일 로그인"),
              ),
            ],
          )
        ],
      )),
    );
  }
}
