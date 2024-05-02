import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/viewModels/user/user_viewmodel.dart';
import 'package:earlips/views/home/home_head_widget.dart';
import 'package:earlips/views/home/widget/bottom_widget.dart';
import 'package:earlips/views/home/widget/mid_widget.dart';
import 'package:earlips/views/home/widget/top_widget.dart';
import 'package:flutter/material.dart';
import 'package:earlips/viewModels/home/home_viewmodel.dart';
import 'package:earlips/views/base/base_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  final User? user =
      FirebaseAuth.instance.currentUser; // FirebaseFirestore 인스턴스 생성

  HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final viewModel = Get.put(UserViewModel());
    return Scaffold(

      backgroundColor: ColorSystem.background,
      body: Container(
        child: SafeArea(
          top: true,
          child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              viewModel.onInit();
              final bool isLoggedIn = snapshot.hasData;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    HomeHeaderWidget(isLoggedIn: isLoggedIn, vm: viewModel),
                    TopWidget(
                      isLoggedIn: isLoggedIn,
                      vm: viewModel,
                    ),
                    MidWidget(),
                    // 로그인 상태에 따라 _Bottom 클래스의 컨테이너 색상을 변경
                    BottomWidget(isLoggedIn: isLoggedIn),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}
