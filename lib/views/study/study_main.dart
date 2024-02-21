import 'dart:ui';

import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/views/auth/login_screen.dart';
import 'package:earlips/views/study/widget/study_main_body_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:earlips/views/base/base_screen.dart';
import 'package:earlips/viewModels/study/study_viewmodel.dart';
import 'package:earlips/views/study/widget/contribution.dart';
import 'package:get/get.dart';

class StudyMain extends BaseScreen<StudyViewModel> {
  const StudyMain({
    super.key,
  });
  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
        body: Container(
      color: ColorSystem.white,
      child: SafeArea(
        top: true,
        child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final bool isLoggedIn = snapshot.hasData;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: const Color(0x000000ff),
                      child: Contribute(
                        isLogin: isLoggedIn,
                      ),
                    ),
                    Stack(
                      children: [
                        const StudyNainBodyWidget(),
                        if (!isLoggedIn)
                          Positioned.fill(
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.grey.withOpacity(0.1),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "homeHeaderGuest".tr,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: ColorSystem.black,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Get.to(() => LoginScreen());
                                          },
                                          icon: const Icon(
                                            Icons.login,
                                            size: 50,
                                            color: ColorSystem.main2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    ));
  }
}
