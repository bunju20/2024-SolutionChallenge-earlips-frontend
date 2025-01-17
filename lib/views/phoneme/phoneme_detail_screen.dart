import 'package:earlips/models/phoneme_model.dart';
import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:earlips/views/phoneme/widget/phoneme_list_widget.dart';
import 'package:earlips/views/word/widget/blue_back_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PhonemeDetailScreen extends StatelessWidget {
  final Phoneme phoneme;
  final String realString;

  PhonemeDetailScreen(
      {super.key, required this.phoneme, required this.realString});


  final wordViewModel = Get.find<WordViewModel>();

  @override
  Widget build(BuildContext context) {
    Get.put(WordViewModel(type: 0));
    wordViewModel.generateDescription(phoneme.symbol);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlueBackAppbar(title: 'Details for ${phoneme.symbol}'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: ColorSystem.main2,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // --------------------------- 발음 카드
                  PhonemeListWidget(
                    phoneme: phoneme,
                    realString: realString,
                  ),
                  SizedBox(
                    height: 70,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        // --------------------------- 발음 안내
                        Text(
                          "word_type_12_height".tr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ColorSystem.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --------------------------- 발음 세부 내용 기입
// image
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Obx(() {
                    // isLoading이 true이면 로딩 인디케이터를 보여줌
                    if (wordViewModel.isLoadingGemini.value) {
                      return const Center(
                        child: CircularProgressIndicator(), // 로딩 인디케이터
                      );
                    } else {
                      // isLoading이 false이면 설명 텍스트를 보여줌
                      return Text(
                        wordViewModel.description.value,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black, // ColorSystem.black으로 가정
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}