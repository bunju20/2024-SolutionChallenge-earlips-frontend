import 'package:earlips/views/auth/logout_dialog.dart';
import 'package:earlips/views/profile/profile_divider_widget.dart';
import 'package:earlips/views/profile/profile_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<User?>(
          stream:
              FirebaseAuth.instance.authStateChanges(), // Stream user changes
          builder: (context, snapshot) {
            // 상태 연결 확인 웨이팅
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 서클 프로그레스바
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // 에러 발생시 안내
              return const Center(child: Text('네트워크 상태를 확인해주세요.'));
            } else if (snapshot.hasData) {
              // --------------------- 로그인 된 상태 ---------------------
              return Column(
                children: [
                  ProfileHeader(user: snapshot.hasData ? snapshot.data : null),
                  const ProfileDividerWidget(), // Modified version with 'r' removed
                  // 로그아웃 버튼
                  ElevatedButton(
                    onPressed: () => showLogoutDialog(context),
                    child: const Text('로그아웃'),
                  ),
                ],
              );
            } else {
              // --------------------- 로그인 안된 상태 ---------------------
              return const Column(
                children: [ProfileHeader(), ProfileDividerWidget()],
              );
            }
          },
        ),
      ),
    );
  }
}
