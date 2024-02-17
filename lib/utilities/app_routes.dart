// ignore_for_file: constant_identifier_names
import 'package:earlips/views/home/home_screen.dart';
import 'package:get/get.dart';


abstract class Routes {
  static const ROOT = '/';
  static const HOME = '/home';
  static const SETTING = '/setting';
  static const ONBOARDING = '/onboarding';

  static final routes = [
    GetPage(
      name: HOME,
      page: () => HomeScreen(),
    ),
    // 다른 라우트들도 이곳에 추가할 수 있습니다.
  ];

}