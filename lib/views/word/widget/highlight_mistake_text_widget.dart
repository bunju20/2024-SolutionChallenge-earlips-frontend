import 'package:flutter/material.dart';

class HighlightMistakesTextWidget extends StatelessWidget {
  final List<dynamic> userWords; // 사용자가 발음한 단어 리스트
  final List<dynamic> wrongIndices; // 잘못 발음한 단어의 인덱스 리스트

  const HighlightMistakesTextWidget({
    super.key,
    required this.userWords,
    required this.wrongIndices,
  });

  @override
  Widget build(BuildContext context) {
    return wrongIndices[0] == -1
        ? const Text("틀린단어 없음")
        : RichText(
            text: TextSpan(
              children: userWords.asMap().entries.map((entry) {
                int idx = entry.key;
                String word = entry.value;
                bool isWrong = wrongIndices.contains(idx);
                return TextSpan(
                  text: "$word ", // 단어와 공백을 포함시킵니다.
                  style: TextStyle(
                    color: isWrong
                        ? Colors.red
                        : Colors.black, // 잘못된 부분은 빨간색으로, 그 외는 검정색으로 표시
                  ),
                );
              }).toList(),
            ),
          );
  }
}
