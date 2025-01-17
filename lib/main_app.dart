import 'package:earlips/languages.dart';
import 'package:earlips/utilities/style/color_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'utilities/app_routes.dart';

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
      translations: Languages(),
      locale: const Locale('ko', 'KR'),
      fallbackLocale: const Locale('ko', 'KR'),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Pretendard',
        colorScheme: ColorSystem.createLightColorScheme(),
        scaffoldBackgroundColor: ColorSystem.background, // More direct usage
      ),
      initialRoute: initialRoute,
      getPages: Routes.routes,
    );
  }
}
