import 'package:earlips/models/phoneme_model.dart';
import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/views/phoneme/widget/phoneme_list_widget.dart';
import 'package:earlips/views/word/widget/blue_back_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PhonemeDetailScreen extends StatelessWidget {
  final Phoneme phoneme;

  const PhonemeDetailScreen({super.key, required this.phoneme});

  @override
  Widget build(BuildContext context) {
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
                  PhonemeListWidget(phoneme: phoneme),
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
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // SvgPicture.asset(
                  //   'assets/images/phoneme/vowels_1.svg',
                  //   width: 90,
                  //   height: 90,
                  // ),
                ],
              ),
            ),
            Text(phoneme.description),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
