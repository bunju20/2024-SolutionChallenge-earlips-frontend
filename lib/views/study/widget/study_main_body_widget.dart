import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/viewModels/user/user_viewmodel.dart';
import 'package:earlips/views/phoneme/phoneme_screen.dart';
import 'package:earlips/views/study/widget/study_card_widget.dart';
import 'package:earlips/views/word/word_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:earlips/views/script/create_script_screen.dart';
import 'package:earlips/views/script/learning_session_screen.dart';

class StudyNainBodyWidget extends StatelessWidget {
  const StudyNainBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserViewModel viewModel = Get.put(UserViewModel()); // viewModel 인스턴스화

    return Container(
      color: ColorSystem.background,
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StudyCardWidget(
                        title: "study_main_title_1".tr,
                        subtitle: "study_main_subtitle_1".tr,
                        imagePath: "assets/images/study/1.png",
                        onTap: () {
                          viewModel.learningLanguage.value == "English"
                              ? Get.to(() => PhonemeScreen(
                                    title: "study_main_title_1".tr,
                                    type: 0,
                                  ))
                              : Get.to(() => WordScreen(
                                    title: "study_main_title_1".tr,
                                    type: 0,
                                  ));
                        },
                        imgSize: 85,
                      ),
                      StudyCardWidget(
                        title: 'study_main_title_2'.tr,
                        subtitle: "study_main_subtitle_2".tr,
                        imagePath: "assets/images/study/2.png",
                        onTap: () {
                          Get.to(() => WordScreen(
                                title: 'study_main_title_2'.tr,
                                type: 1,
                              ));
                        },
                        imgSize: 150,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StudyCardWidget(
                        title: "study_main_title_3".tr,
                        subtitle: "study_main_subtitle_3".tr,
                        imagePath: "assets/images/study/3.png",
                        onTap: () {
                          Get.to(() => WordScreen(
                                title: "study_main_title_3".tr,
                                type: 2,
                              ));
                        },
                        imgSize: 85,
                      ),
                      StudyCardWidget(
                        title: "study_main_title_4".tr,
                        subtitle: "study_main_subtitle_4".tr,
                        imagePath: "assets/images/study/4.png",
                        onTap: () {
                          Get.to(() =>
                              const LearningSessionScreen(isStudyMode: true));
                        },
                        imgSize: 85,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
