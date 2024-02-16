import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/viewModels/user/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileLanguageScreen extends StatelessWidget {
  const ProfileLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Get.find<UserViewModel>();
    userViewModel.loadLanguageSettings();

    String title = userViewModel.systemLanguage.value == '한국어'
        ? '언어 설정'
        : 'Language Settings';

    // systemLanguage, learningLanguage
    String systemLanguage = userViewModel.systemLanguage.value == '한국어'
        ? '시스템 언어'
        : 'System Language';

    String learningLanguage = userViewModel.systemLanguage.value == '한국어'
        ? '학습 언어'
        : 'Learning Language';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          _buildLanguageSettingSection(
            title: systemLanguage,
            selectedLanguage: userViewModel.systemLanguage,
            onLanguageSelected: (value) {
              userViewModel.systemLanguage.value = value!;
              userViewModel.updateLanguageSettings();
            },
            languageOptions: [
              const DropdownMenuItem(value: '한국어', child: Text('한국어')),
              const DropdownMenuItem(value: 'English', child: Text('English')),
            ],
          ),
          _buildLanguageSettingSection(
            title: learningLanguage,
            selectedLanguage: userViewModel.learningLanguage,
            onLanguageSelected: (value) {
              userViewModel.learningLanguage.value = value!;
              userViewModel.updateLanguageSettings();
            },
            languageOptions: [
              const DropdownMenuItem(value: '한국어', child: Text('한국어')),
              const DropdownMenuItem(value: 'English', child: Text('English')),
            ],
          ),
        ],
      ),
    );
  }

  // 셋팅 섹션 위젯
  Widget _buildLanguageSettingSection({
    required String title,
    required RxString selectedLanguage,
    required Function(String?) onLanguageSelected,
    required List<DropdownMenuItem<String>> languageOptions,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorSystem.gray1),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          Obx(() => DropdownButton<String>(
                value: selectedLanguage.value,
                items: languageOptions,
                onChanged: onLanguageSelected,
              )),
        ],
      ),
    );
  }
}
