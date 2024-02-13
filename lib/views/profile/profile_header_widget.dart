import 'package:earlips/views/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileHeader extends StatelessWidget {
  final User? user;

  const ProfileHeader({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 62, 20, 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Welcome or Login Text
            user != null
                ? Text("오늘도 이어립스 해볼까요, ${user!.email}")
                : GestureDetector(
                    // Make the text clickable
                    onTap: () => Get.to(() => const LoginScreen()),
                    child: const Text(
                      "로그인 하러가기",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
