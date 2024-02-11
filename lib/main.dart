import 'package:earlips/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:earlips/main_app.dart';

void main() async {
  /* Open .env file */
  await dotenv.load(fileName: "assets/config/.env");
  await initializeDateFormatting();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp(initialRoute: "/"));
}
