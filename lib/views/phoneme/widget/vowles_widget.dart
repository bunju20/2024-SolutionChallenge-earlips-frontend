import 'package:earlips/models/phoneme_model.dart';
import 'package:earlips/views/phoneme/phoneme_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VowelsWidget extends StatelessWidget {
  final int type; // 0 for vowels, 1 for consonants, 2 for R-Controlled Vowels
  const VowelsWidget({
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Phoneme> phonemes = _getPhonemeList();

    return SizedBox(
      height: 200,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: phonemes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => PhonemeDetailScreen(
                    phoneme: phonemes[index],
                    realString: phonemes[index].symbol,
                  ));
            },
            child: Card(
              child: Center(
                child: Text(phonemes[index].symbol,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Phoneme> _getPhonemeList() {
    switch (type) {
      case 0:
        return vowels;
      case 1:
        return consonants;
      case 2:
        return rControlledVowels;
      default:
        return vowels; // Default to vowels if something goes wrong
    }
  }
}
