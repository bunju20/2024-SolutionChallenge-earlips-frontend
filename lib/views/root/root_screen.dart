import 'package:earlips/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:earlips/views/home/home_screen.dart';
import 'package:earlips/views/root/custom_bottom_navigation_bar.dart';
import '../../utilities/app_routes.dart';
import '../../viewModels/root/root_viewmodel.dart';
import '../base/base_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RootScreen extends BaseScreen<RootViewModel> {
  const RootScreen({super.key});

  @override
  Color? get screenBackgroundColor => const Color(0xFFAAA4F8);

  @override
  Widget buildBody(BuildContext context) {
    return Obx(
      () => IndexedStack(
        index: viewModel.selectedIndex,
        children: [
          HomeScreen(),
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
            Get.toNamed(Routes.HOME);
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
