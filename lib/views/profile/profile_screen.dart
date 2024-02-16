import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/views/profile/profile_divider_widget.dart';
import 'package:earlips/views/profile/profile_header_widget.dart';
import 'package:earlips/views/profile/profile_setting_row_btn_widget.dart';
import 'package:earlips/views/profile/profile_setting_row_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorSystem.white,
        child: SafeArea(
          child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
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
                    ProfileHeader(
                        user: snapshot.hasData ? snapshot.data : null),
                    const ProfileSettingRowBtnWidget(
                        iconImg: 'assets/icons/icon-setting1.svg',
                        text: '시스템 및 학습 언어 설정',
                        routeLinkText: '/profile/language-setting'),
                    const ProfileSettingRowBtnWidget(
                        iconImg: 'assets/icons/icon-setting.svg',
                        text: '계정 관리',
                        routeLinkText: '/profile/account'),
                    const ProfileDividerWidget(),
                    const ProfileSettingRowBoxWidget(
                        text: "버전 정보", routerLinkText: null),
                    const ProfileSettingRowBoxWidget(
                        text: "문의", routerLinkText: null),
                  ],
                );
              } else {
                // --------------------- 로그인 안된 상태 ---------------------
                return Column(
                  children: [
                    ProfileHeader(),
                    const ProfileSettingRowBtnWidget(
                        iconImg: 'assets/icons/icon-setting1.svg',
                        text: '시스템 및 학습 언어 설정',
                        routeLinkText: '/profile/language-setting'),
                    const ProfileDividerWidget(),
                    const ProfileSettingRowBoxWidget(
                        text: "버전 정보", routerLinkText: null),
                    const ProfileSettingRowBoxWidget(
                        text: "문의", routerLinkText: null),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
