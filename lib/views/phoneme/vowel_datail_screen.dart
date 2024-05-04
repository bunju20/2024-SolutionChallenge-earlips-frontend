import 'package:earlips/models/phoneme_model.dart';
import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/views/phoneme/widget/phoneme_list_widget.dart';
import 'package:earlips/views/word/widget/blue_back_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VowelDetailScreen extends StatelessWidget {
  final Phoneme phoneme;

  const VowelDetailScreen({super.key, required this.phoneme, required String realString});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlueBackAppbar(title: 'Details for ${phoneme.symbol}'),
      ),
      body: SingleChildScrollView(
        child: Center(
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
                    PhonemeListWidget(phoneme: phoneme, realString: '',),
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
              _BottomBox(phoneme: phoneme),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomBox extends StatelessWidget {
  const _BottomBox({super.key, required this.phoneme});

  final Phoneme phoneme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          phoneme.imageSrc,
          width: Get.width * 0.50,
        ),
        const SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.all(20.0),
          width: Get.width - 40,
          margin: EdgeInsets.only(bottom: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0x80FFFFFF),  // 80은 50%
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            phoneme.description,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}