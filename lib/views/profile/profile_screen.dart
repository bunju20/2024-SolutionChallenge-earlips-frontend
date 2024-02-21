import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/views/profile/profile_divider_widget.dart';
import 'package:earlips/views/profile/profile_header_widget.dart';
import 'package:earlips/views/profile/profile_setting_row_btn_widget.dart';
import 'package:earlips/views/profile/profile_setting_row_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Container(
          color: ColorSystem.white,
          child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              // 상태 연결 확인 웨이팅
              if (snapshot.connectionState == ConnectionState.waiting) {
                // 서클 프로그레스바
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // 에러 발생시 안내
                return Center(child: Text('check_network_connection'.tr));
              } else if (snapshot.hasData) {
                // --------------------- 로그인 된 상태 ---------------------
                return Column(
                  children: [
                    ProfileHeader(
                        user: snapshot.hasData ? snapshot.data : null),
                    ProfileSettingRowBtnWidget(
                        iconImg: 'assets/icons/icon-setting1.svg',
                        text: 'mypage_menu1'.tr,
                        routeLinkText: '/profile/language-setting'),
                    ProfileSettingRowBtnWidget(
                        iconImg: 'assets/icons/icon-setting.svg',
                        text: 'mypage_menu2'.tr,
                        routeLinkText: '/profile/account'),
                    const ProfileDividerWidget(),
                    ProfileSettingRowBoxWidget(
                        text: "mypage_menu3".tr, routerLinkText: null),
                    ProfileSettingRowBoxWidget(
                        text: "mypage_menu4".tr, routerLinkText: null),
                  ],
                );
              } else {
                // --------------------- 로그인 안된 상태 ---------------------
                return Column(
                  children: [
                    ProfileHeader(),
                    ProfileSettingRowBtnWidget(
                        iconImg: 'assets/icons/icon-setting1.svg',
                        text: 'mypage_menu1'.tr,
                        routeLinkText: '/profile/language-setting'),
                    const ProfileDividerWidget(),
                    ProfileSettingRowBoxWidget(
                        text: "mypage_menu3".tr, routerLinkText: null),
                    ProfileSettingRowBoxWidget(
                        text: "mypage_menu4".tr, routerLinkText: null),
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
