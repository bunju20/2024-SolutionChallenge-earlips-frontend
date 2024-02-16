import 'package:earlips/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> authDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String textConfirm,
  required String textCancel,
}) async {
  final AuthService authService = AuthService();

  return Get.defaultDialog(
    title: title,
    content: Text(content),
    textConfirm: textConfirm,
    textCancel: textCancel,
    onCancel: () => Get.back(),
    onConfirm: () async {
      /// title == '로그아웃' ? 로그아웃 : 회원탈퇴
      title == '로그아웃'
          ? await authService.signOut()
          : await authService.withdraw();
      Get.back();
    },
  );
}
