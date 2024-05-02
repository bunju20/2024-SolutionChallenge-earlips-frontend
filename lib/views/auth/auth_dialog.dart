import 'package:earlips/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// [authDialog] is a function that shows a dialog to confirm the user's authentication.
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
      title == 'profile_account_logout'.tr
          ? await authService.signOut()
          : await authService.withdraw();
      Get.offAllNamed('/');
    },
  );
}
