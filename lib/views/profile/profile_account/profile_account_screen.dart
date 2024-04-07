import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/views/auth/auth_dialog.dart';
import 'package:earlips/views/base/default_back_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

/// [ProfileAccountScreen] is a screen that allows the user to log out or sign out.
class ProfileAccountScreen extends StatelessWidget {
  const ProfileAccountScreen({super.key});

  /// [buildListTile] is a function that creates a ListTile.
  Widget buildListTile(BuildContext context, String title, String alertTitle,
      String alertContent, String confirmText, String cancelText) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title.tr,
        style: const TextStyle(fontSize: 16, color: Color(0xff151515)),
      ),
      onTap: () {
        authDialog(
          context: context,
          title: alertTitle.tr,
          content: alertContent.tr,
          textConfirm: confirmText.tr,
          textCancel: cancelText.tr,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(
          title: "profile_account_title".tr,
        ),
      ),
      body: Container(
        color: ColorSystem.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                buildListTile(
                  context,
                  'profile_account_logout',
                  'profile_account_logout_alert_title',
                  'profile_account_logout_alert_content',
                  'profile_account_logout_alert_title',
                  'profile_account_logout_alert_cancel',
                ),
                buildListTile(
                  context,
                  'profile_account_signout',
                  'profile_account_signout',
                  'profile_account_signout_alert_content',
                  'profile_account_signout_alert_confirm',
                  'profile_account_signout_alert_cancel',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
