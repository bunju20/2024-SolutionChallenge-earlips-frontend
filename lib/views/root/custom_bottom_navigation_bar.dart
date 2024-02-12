import 'package:earlips/utilities/style/color_styles.dart';
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
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: viewModel.selectedIndex,
          onTap: viewModel.changeIndex,

          // 아이템의 색상
          unselectedItemColor: ColorStyles.gray3,
          selectedItemColor: ColorStyles.main,

          // 탭 애니메이션 변경 (fixed: 없음)
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorStyles.white,

          // Bar에 보여질 요소. icon과 label로 구성.
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/house.svg',
                  height: 24,
                  colorFilter: viewModel.selectedIndex == 0
                      ? const ColorFilter.mode(
                          ColorStyles.main, BlendMode.srcATop)
                      : const ColorFilter.mode(
                          ColorStyles.gray3, BlendMode.srcATop),
                ),
                label: "홈"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/house.svg',
                  height: 24,
                  colorFilter: viewModel.selectedIndex == 1
                      ? const ColorFilter.mode(
                          ColorStyles.main, BlendMode.srcATop)
                      : const ColorFilter.mode(
                          ColorStyles.gray3, BlendMode.srcATop),
                ),
                label: "내정보"),
          ],
        ),
      ),
    );
  }
}
