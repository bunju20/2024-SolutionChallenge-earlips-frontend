import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/views/auth/auth_dialog.dart';
import 'package:earlips/views/base/default_back_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ProfileAccountScreen extends StatelessWidget {
  const ProfileAccountScreen({super.key});

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
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('profile_account_logout'.tr,
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xff151515))),
                  onTap: () {
                    authDialog(
                      context: context,
                      title: 'profile_account_logout_alert_title'.tr,
                      content: 'profile_account_logout_alert_content'.tr,
                      textConfirm: 'profile_account_logout_alert_title'.tr,
                      textCancel: 'profile_account_logout_alert_cancel'.tr,
                    );
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('profile_account_signout'.tr,
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xff151515))),
                  onTap: () {
                    authDialog(
                      context: context,
                      title: 'profile_account_signout'.tr,
                      content: 'profile_account_signout_alert_content'.tr,
                      textConfirm: 'profile_account_signout_alert_confirm'.tr,
                      textCancel: 'profile_account_signout_alert_cancel'.tr,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
