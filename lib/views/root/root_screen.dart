import 'package:earlips/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:earlips/views/home/home_screen.dart';
import 'package:earlips/views/root/custom_bottom_navigation_bar.dart';
import '../../viewModels/root/root_viewmodel.dart';
import '../base/base_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:earlips/views/study/study_main.dart';
import 'package:earlips/viewModels/user/user_viewmodel.dart';

class RootScreen extends BaseScreen<RootViewModel> {
  const RootScreen({super.key});

  //userviewModel
  @override
  Color? get screenBackgroundColor => const Color(0xFFAAA4F8);

  @override
  Widget buildBody(BuildContext context) {
    return Obx(
      () => IndexedStack(
        index: viewModel.selectedIndex,
        children: [
          HomeScreen(),
          const StudyMain(),
          const ProfileScreen(),
        ],
      ),
    );
  }

  @override
  Widget? buildBottomNavigationBar(BuildContext context) {
    return const CustomBottomNavigationBar();
  }

  @override
  Widget? get buildFloatingActionButton => Container(
        width: 70,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1FA9DC),
              Color(0xFF1FA9DC),
              Color(0xFF1FA9DC),
            ],
            stops: [0, 0.5, 1],
          ),
        ),
        child: FloatingActionButton.large(
          onPressed: () {
            final UserViewModel userViewModel = Get.find<UserViewModel>();
            userViewModel.fetchAndSetGraphData();
            viewModel.changeIndex(0);
            // 홈 스크린으로 이동하기 위해 selectedIndex를 0으로 설정
          },
          elevation: 0,
          highlightElevation: 2,
          shape: const CircleBorder(),
          backgroundColor: Colors.transparent,
          splashColor: const Color(0xFF98E3FF),
          child: SvgPicture.asset(
            'assets/icons/house.svg',
            fit: BoxFit.scaleDown,
            color: Colors.white,
          ),
        ),
      );

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerDocked;

  @override
  bool get extendBodyBehindAppBar => true;

  @override
  Color? get unSafeAreaColor => const Color(0xFFFFFFFF);

  @override
  bool get setTopOuterSafeArea => false;
}
