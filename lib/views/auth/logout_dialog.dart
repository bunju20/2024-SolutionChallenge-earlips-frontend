import 'package:earlips/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  final AuthService authService = AuthService();

  return Get.defaultDialog(
    title: '로그아웃',
    content: const Text('정말 로그아웃하시겠습니까?'),
    textConfirm: '로그아웃',
    textCancel: '취소',
    onCancel: () => Get.back(), // Equivalent to closing the dialog
    onConfirm: () async {
      await authService.signOut();
      Get.back(); // Close the dialog after signOut
    },
  );
}
