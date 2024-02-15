import 'package:flutter/material.dart';
import 'package:earlips/viewModels/home/home_viewmodel.dart';
import 'package:earlips/views/base/base_screen.dart';
import 'package:earlips/views/home/learning_session_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../auth/email_signup_screen.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => Get.to(() => LearningSessionScreen()),
        child: const Text("대본으로 학습하기"),
      ),
    );
  }
}
