import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/views/study/widget/study_card_widget.dart';
import 'package:earlips/views/word/word_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:earlips/views/paragraph/create_script_screen.dart';
import 'package:earlips/views/paragraph/learning_session_screen.dart';

class StudyNainBodyWidget extends StatelessWidget {
  const StudyNainBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                        title: "음소 교정",
                        subtitle: "옴소 교정 및 발음 테스트",
                        imagePath: "assets/images/study/1.png",
                        onTap: () {
                          Get.to(() => const WordScreen(
                                title: "음소 교정",
                                type: 0,
                              ));
                        },
                        imgSize: 85,
                      ),
                      StudyCardWidget(
                        title: "단어 교정",
                        subtitle: "단어 교정 및 발음 테스트",
                        imagePath: "assets/images/study/2.png",
                        onTap: () {
                          Get.to(() => const WordScreen(
                                title: "단어 교정",
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
                        title: "문장 교정",
                        subtitle: "문장 교정 및 발음 테스트",
                        imagePath: "assets/images/study/3.png",
                        onTap: () {
                          Get.to(() => const WordScreen(
                                title: "문장 교정",
                                type: 2,
                              ));
                        },
                        imgSize: 85,
                      ),
                      StudyCardWidget(
                        title: "문단 교정",
                        subtitle: "대본 입력 및 발음 테스트",
                        imagePath: "assets/images/study/4.png",
                        onTap: () {
                          Get.to(() => LearningSessionScreen(
                          ));
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
