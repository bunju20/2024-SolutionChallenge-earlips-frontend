// ignore_for_file: constant_identifier_names
import 'package:earlips/views/home/home_screen.dart';
import 'package:earlips/views/profile/profile_account/profile_account_screen.dart';
import 'package:earlips/views/profile/profile_language_setting/profile_language_setting.dart';
import 'package:earlips/views/profile/profile_screen.dart';
import 'package:get/get.dart';

abstract class Routes {
  static const ROOT = '/';
  static const HOME = '/home';
  static const SETTING = '/setting';
  static const ONBOARDING = '/onboarding';
  static const PROFILE = '/profile';
  static const PROFILE_ACCOUNT = '/profile/account';
  static const PROFILE_LANGUAGE_SETTING = '/profile/language-setting';

  static final routes = [
    GetPage(
      name: HOME,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: PROFILE,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: PROFILE_ACCOUNT,
      page: () => const ProfileAccountScreen(),
    ),
    GetPage(
      name: PROFILE_LANGUAGE_SETTING,
      page: () => const ProfileLanguageScreen(),
    ),
    // 다른 라우트들도 이곳에 추가할 수 있습니다.
  ];
}
