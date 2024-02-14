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
      child: GestureDetector(
        onTap: () => user != null ? null : Get.to(() => LoginScreen()),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 62, 20, 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 유저 정보가 있으면 이메일을 보여주고, 없으면 로그인 버튼 보여줌
                user != null
                    ? Text("오늘도 이어립스 해볼까요, ${user!.email}")
                    : const Text(
                        "로그인 하러가기",
                        style: TextStyle(color: Colors.blue),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
