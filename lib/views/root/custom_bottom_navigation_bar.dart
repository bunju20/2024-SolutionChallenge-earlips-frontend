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
          padding: const EdgeInsets.all(0),
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 65,
            color: const Color(0xFFFFFFFF),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavigationBarItem(
                  index: 0,
                  size: 60,
                  svgPath: 'assets/icons/learning.svg',
                ),
                const SizedBox(width: 70),
                _buildBottomNavigationBarItem(
                  index: 1,
                  size: 60,
                  svgPath: 'assets/icons/mypage.svg',
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
  }) =>
      Expanded(
        child: InkWell(
          onTap: () => viewModel.changeIndex(index),
          child: SvgPicture.asset(
            svgPath,
            width: size,
            colorFilter: viewModel.selectedIndex == index
                ? const ColorFilter.mode(Color(0xFF1FA9DC), BlendMode.srcATop)
                : const ColorFilter.mode(Color(0xFF67686D), BlendMode.srcATop),
          ),
        ),
      );
}
