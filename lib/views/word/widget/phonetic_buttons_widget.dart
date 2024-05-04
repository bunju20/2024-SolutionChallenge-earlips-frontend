import 'package:earlips/models/phoneme_model.dart';
import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/views/phoneme/phoneme_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../phoneme/vowel_datail_screen.dart';
import 'package:earlips/models/phoneme_model.dart';


class PhoneticButtons extends StatelessWidget {
  final String phoneticString;
  final String description;
  final String realString;

  const PhoneticButtons(
      {super.key,
      required this.phoneticString,
      required this.description,
      required this.realString});


  @override
  Widget build(BuildContext context) {
    // Splitting the phonetic string into components
    List<String> phonemesWord = phoneticString.replaceAll('/', '').split(' ');

    String cleanedString = phoneticString
        .replaceAll('ˈ', '')
        .replaceAll('ː', '')
        .replaceAll('.', '');

    List<String> phonemesVowels = cleanedString.replaceAll(' ', '').split('');

    // real String Split
    List<String> realWords = realString.split(' ');

    return Column(
      children: [
        const Text("Split Words",
            style: TextStyle(
                fontSize: 16,
                color: ColorSystem.black,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0, // Space between buttons
          children: phonemesWord
              .map((phoneme) => ElevatedButton(
                    onPressed: () {
                      // Navigate to a detail page for the phoneme
                      Get.to(() => PhonemeDetailScreen(
                          phoneme: Phoneme(
                              symbol: phoneme, description: '', imageSrc: ''),
                          realString: realString));
                    },
                    child: Text(phoneme,
                        style: const TextStyle(
                            fontSize: 16, color: ColorSystem.black)),
                  ))
              .toList(),
        ),
        const SizedBox(height: 20),
        const Text("Split Phonemes",
            style: TextStyle(
                fontSize: 16,
                color: ColorSystem.black,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          children: phonemesVowels
              .map((phonemeSymbol) {
            Phoneme phoneme = vowels.firstWhere(
                    (vowel) => vowel.symbol == phonemeSymbol,
                orElse: () => Phoneme(symbol: phonemeSymbol, description: 'Description not found', imageSrc: 'assets/images/phoneme/placeholder.png')
            );
            return ElevatedButton(
              onPressed: () {
                Get.to(() => VowelDetailScreen(
                    phoneme: phoneme,
                    realString: realString));
              },
              child: Text(phonemeSymbol, style: const TextStyle(fontSize: 16, color: ColorSystem.black)),
            );
          }).toList(),
        ),

      ],
    );
  }
}


