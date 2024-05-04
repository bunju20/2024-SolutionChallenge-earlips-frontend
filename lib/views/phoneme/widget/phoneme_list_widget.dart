import 'package:earlips/models/phoneme_model.dart';
import 'package:earlips/models/word_data_model.dart';
import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhonemeListWidget extends StatelessWidget {
  final Phoneme phoneme;
  final String realString;

  const PhonemeListWidget(
      {super.key, required this.phoneme, required this.realString});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorSystem.white,
          border: Border.all(
            color: const Color(0xffB3CBE2),
            width: 4,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            ),
            ListTile(
              tileColor: Colors.white,
              title: Text(
                realString,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: ColorSystem.black,
                ),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                phoneme.symbol,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: ColorSystem.gray4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
