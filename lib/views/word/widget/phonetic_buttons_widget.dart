import 'package:earlips/models/phoneme_model.dart';
import 'package:earlips/utilities/style/color_system.dart';
import 'package:earlips/views/phoneme/phoneme_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

    // List<String> phonemes2 = 'b.juː.t.ɪ.f.ə.l'.split('.');

    // final gemini = Gemini.instance;

    // // Gemini API를 호출하여 결과 처리
    // gemini
    //     .text(
    //         "$word 를 발음하면 $speak 이야, 이를 청각장애인이 시각적으로 보고 발음할 수 있도록 한글이 아닌 영어로 세세하게 말해줘")
    //     .then((value) {
    //   // 성공적으로 결과를 받았을 때 출력 및 상태 업데이트
    //   wordViewModel.description.value = value?.output ?? "";
    //   print(value?.output); // output이 정확한 필드인지 확인하세요. API 응답에 따라 다를 수 있습니다.
    // }).catchError((error) {
    //   // 에러 처리
    //   print('Error occurred: $error');
    // });

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
          spacing: 8.0, // Space between buttons
          children: phonemesVowels
              .map((phoneme) => ElevatedButton(
                    onPressed: () {
                      print(description);
                      Get.to(() => PhonemeDetailScreen(
                          phoneme: Phoneme(
                              symbol: phoneme,
                              description: description,
                              imageSrc: ''),
                          realString: realString));
                    },
                    child: Text(phoneme,
                        style: const TextStyle(
                            fontSize: 16, color: ColorSystem.black)),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
