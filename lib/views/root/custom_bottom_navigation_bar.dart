import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:earlips/viewModels/root/root_viewmodel.dart';
import 'package:earlips/views/base/base_widget.dart';

class CustomBottomNavigationBar extends BaseWidget<RootViewModel> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () => Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        child: BottomAppBar(
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 75,
            color: const Color(0xFFFFFFFF),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildBottomNavigationBarItem(
                  index: 1,
                  size: 30,
                  svgPath: 'assets/icons/learning.svg',
                  text: 'navi_learning'.tr,
                ),
                const SizedBox(width: 70),
                _buildBottomNavigationBarItem(
                  index: 2,
                  size: 30,
                  svgPath: 'assets/icons/mypage.svg',
                  text: 'navi_mypage'.tr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBarItem({
    required int index,
    required double size,
    required String svgPath,
    required String text,
  }) =>
      Expanded(
        child: InkWell(
          onTap: () => viewModel.changeIndex(index),
          child: Column(
            children: [
              SvgPicture.asset(
                svgPath,
                width: size,
                colorFilter: viewModel.selectedIndex == index
                    ? const ColorFilter.mode(
                        Color(0xFF1FA9DC), BlendMode.srcATop)
                    : const ColorFilter.mode(
                        Color(0xFF67686D), BlendMode.srcATop),
              ),
              const SizedBox(height: 5),
              Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                  color: viewModel.selectedIndex == index
                      ? const Color(0xFF1FA9DC)
                      : const Color(0xFF67686D),
                ),
              ),
            ],
          ),
        ),
      );
}
