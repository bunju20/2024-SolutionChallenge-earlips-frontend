import 'package:earlips/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:earlips/main_app.dart';

void main() async {
  /* Open .env file */
  await dotenv.load(fileName: "assets/config/.env");
  await initializeDateFormatting();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(EasyLocalization(
      // 지원 언어 리스트
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'US'),
      ],
      //path: 언어 파일 경로
      path: 'assets/translations',
      //fallbackLocale supportedLocales에 설정한 언어가 없는 경우 설정되는 언어
      fallbackLocale: const Locale('en', 'US'),
      //startLocale을 지정하면 초기 언어가 설정한 언어로 변경됨
      //만일 이 설정을 하지 않으면 OS 언어를 따라 기본 언어가 설정됨
      //startLocale: Locale('ko', 'KR')
      child: const MainApp(initialRoute: "/")));
}
