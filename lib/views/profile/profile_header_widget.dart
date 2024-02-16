import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/viewModels/user/user_viewmodel.dart';
import 'package:earlips/views/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileHeader extends StatelessWidget {
  final User? user;

  ProfileHeader({super.key, this.user});
  final UserViewModel userViewmodel = Get.put(UserViewModel());
  //getuserData

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorSystem.background,
      child: GestureDetector(
        onTap: () => user != null ? null : Get.to(() => LoginScreen()),
        child: Container(
          color: ColorSystem.background,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 62, 20, 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 유저 정보가 있으면 이메일을 보여주고, 없으면 로그인 버튼 보여줌
                user != null
                    ? Text("${user!.displayName}님 반가워요!",
                        style: const TextStyle(
                            color: ColorSystem.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))
                    : const Text(
                        "로그인 하러가기",
                        style: TextStyle(
                            color: ColorSystem.main,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
