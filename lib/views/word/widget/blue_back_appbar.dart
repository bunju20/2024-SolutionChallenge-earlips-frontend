import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/views/base/default_back_appbar.dart';

class BlueBackAppbar extends DefaultBackAppbar {
  const BlueBackAppbar({super.key, required super.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorSystem.white),
      ),
      centerTitle: true,
      backgroundColor: ColorSystem.main2, // Set the background color to blue
      automaticallyImplyLeading: true,
      leadingWidth: 90,
      leading: TextButton.icon(
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          foregroundColor: ColorSystem.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        icon: SvgPicture.asset("assets/icons/back_white.svg"),
        label: Text(
          "appbar_back".tr,
          style: const TextStyle(
            color: ColorSystem.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}
