import 'package:earlips/services/auth/auth_service.dart';
import 'package:earlips/views/auth/email_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
            fit: BoxFit.cover, // Make the image cover the entire screen
          ),
        ),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      SvgPicture.asset(
                        "assets/icons/google.svg",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(width: 20),
                      const Text("구글 계정으로 로그인", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
            // --------------------- 이메일 로그인 ---------------------
            InkWell(
              onTap: () {
                Get.to(() => const EmailLoginScreen());
              },
              child: Card(
                margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      SvgPicture.asset(
                        "assets/icons/mailbox.svg",
                        height: 25,
                      ),
                      const SizedBox(width: 20),
                      const Text("이메일로 로그인", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        )),
      ),
    );
  }
}
