import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/viewModels/user/user_viewmodel.dart';
import 'package:earlips/views/base/default_back_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ProfileLanguageScreen extends StatelessWidget {
  const ProfileLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Get.find<UserViewModel>();
    userViewModel.loadLanguageSettings();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(
          title: 'language_setting_title'.tr,
        ),
      ),
      body: Container(
        width: double.infinity,
        color: ColorSystem.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLanguageSettingSection(
                title: 'language_setting_system'.tr,
                selectedLanguage: userViewModel.systemLanguage,
                onLanguageSelected: (value) {
                  userViewModel.systemLanguage.value = value!;
                  userViewModel.updateLanguageSettings(value);
                },
                languageOptions: [
                  DropdownMenuItem(value: '한국어', child: Text('korean'.tr)),
                  DropdownMenuItem(value: 'English', child: Text('english'.tr)),
                ],
              ),
              const SizedBox(height: 20),
              _buildLanguageSettingSection(
                title: 'language_setting_learning'.tr,
                selectedLanguage: userViewModel.learningLanguage,
                onLanguageSelected: (value) {
                  userViewModel.learningLanguage.value = value!;
                  userViewModel.updateLanguageSettings(value);
                },
                languageOptions: [
                  DropdownMenuItem(value: '한국어', child: Text('korean'.tr)),
                  DropdownMenuItem(value: 'English', child: Text('english'.tr)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 셋팅 섹션 위젯
// 셋팅 섹션 위젯
  Widget _buildLanguageSettingSection({
    required String title,
    required RxString selectedLanguage,
    required Function(String?) onLanguageSelected,
    required List<DropdownMenuItem<String>> languageOptions,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        Obx(() => DropdownButton<String>(
              value: selectedLanguage.value,
              items: languageOptions,
              onChanged: (newValue) {
                onLanguageSelected(newValue);
              },
              hint: Text('select_language'.tr),
            )),
      ],
    );
  }
}
