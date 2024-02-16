import 'package:earlips/views/profile/profile_account/profile_account_screen.dart';
import 'package:earlips/views/profile/profile_language_setting/profile_language_setting.dart';
import 'package:earlips/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:earlips/bindings/root_binding.dart';
import 'views/root/root_screen.dart';

class MainApp extends StatelessWidget {
  final String initialRoute;

  const MainApp({
    super.key,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    // Remove splash
    FlutterNativeSplash.remove();

    return GetMaterialApp(
      title: "earlips",
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Pretendard',
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFf6f6f8),
      ),
      initialRoute: initialRoute,
      getPages: [
        GetPage(
            name: '/', page: () => const RootScreen(), binding: RootBinding()),
        // binding:
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        GetPage(
            name: '/profile/account', page: () => const ProfileAccountScreen()),
        GetPage(
            name: '/profile/language-setting',
            page: () => const ProfileLanguageScreen()),
      ],
    );
  }
}
