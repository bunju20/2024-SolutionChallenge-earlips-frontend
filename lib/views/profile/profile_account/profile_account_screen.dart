import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/views/auth/auth_dialog.dart';
import 'package:flutter/material.dart';

class ProfileAccountScreen extends StatelessWidget {
  const ProfileAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorSystem.white,
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('로그아웃',
                    style: TextStyle(fontSize: 16, color: Color(0xff151515))),
                onTap: () {
                  authDialog(
                    context: context,
                    title: '로그아웃',
                    content: '로그아웃 하시겠습니까?',
                    textConfirm: '로그아웃',
                    textCancel: '취소',
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('회원 탈퇴',
                    style: TextStyle(fontSize: 16, color: Color(0xff151515))),
                onTap: () {
                  authDialog(
                    context: context,
                    title: '회원탈퇴',
                    content: '탈퇴 하시겠습니까?',
                    textConfirm: '탈퇴',
                    textCancel: '취소',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
