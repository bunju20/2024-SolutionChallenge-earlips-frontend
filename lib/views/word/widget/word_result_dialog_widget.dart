import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/viewModels/record/record_viewmodel.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:earlips/views/word/widget/fail_word_dialog_widget.dart';
import 'package:earlips/views/word/widget/sucess_word_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> WordResultDialogWidget(RecordViewModel model,
    WordViewModel wordViewModel, PageController pageController) {
  return Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.all(20),
      surfaceTintColor: ColorSystem.white,
      title: Text(
        'result_title'.tr,
        style: const TextStyle(
          color: ColorSystem.black,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
      content: GetBuilder<RecordViewModel>(
        builder: (model) => SizedBox(
          height: 100,
          child: Column(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                model.response['pronunciation'] != null
                    ? '${'pitch'.tr}: ${model.response['pronunciation']}'
                    : 'pitch_null'.tr,
                style: const TextStyle(
                  color: ColorSystem.black,
                  fontSize: 16,
                ),
              ),
              Text(
                  model.response['similarity'] != null
                      ? '${'accuracy'.tr}: ${model.response['similarity']}'
                      : "",
                  style: const TextStyle(
                    color: ColorSystem.black,
                    fontSize: 16,
                  )),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            if (model.response['similarity'] >= 70) {
              SucessWordDialogWidget(wordViewModel, pageController);
            } else {
              // 80 미만일 경우 다른 AlertDialog를 표시 다시하기 혹은 다음으로
              FailWordDialogWidget(wordViewModel, pageController);
            }
          },
          child: Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              decoration: BoxDecoration(
                color: ColorSystem.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: ColorSystem.black),
              ),
              child: Text(
                'cofirm'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: ColorSystem.black,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
