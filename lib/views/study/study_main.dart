import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/views/study/widget/study_main_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:earlips/views/base/base_screen.dart';
import 'package:earlips/viewModels/study/study_viewmodel.dart';
import 'package:earlips/views/study/widget/contribution.dart';

class StudyMain extends BaseScreen<StudyViewModel> {
  const StudyMain({super.key});
  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
        body: Container(
      color: ColorSystem.white,
      child: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                color: const Color(0x000000ff),
                child: const Contribute(),
              ),
              const StudyNainBodyWidget(),
            ],
          ),
        ),
      ),
    ));
  }
}
