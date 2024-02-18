import 'package:earlips/models/word_data_model.dart';
import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/viewModels/word/word_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WordList extends StatefulWidget {
  final List<WordData> wordDataList;
  final int type;

  PageController pageController;

  WordList(
      {super.key,
      required this.wordDataList,
      required this.pageController,
      required this.type});

  @override
  _WordListState createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  final wordViewModel = Get.find<WordViewModel>(); // Access your ViewModel!

  @override
  void initState() {
    super.initState();
    widget.pageController =
        PageController(initialPage: wordViewModel.currentIndex.value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.165,
      child: PageView.builder(
        controller: widget.pageController,
        itemCount: widget.wordDataList.length,
        onPageChanged: (index) {
          wordViewModel.currentIndex.value = index;
        },
        itemBuilder: (context, index) {
          final wordData = widget.wordDataList[index];
          final isDone = wordData.userWord?.isDone ?? false;
          final doneDate = wordData.userWord?.doneDate ?? '';

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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${wordViewModel.currentIndex.value + 1}/${widget.wordDataList.length}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorSystem.gray5,
                          ),
                        ),

                        // isDone 여부에 따라 다른 체크박스 아이콘을 표시합니다.
                        isDone
                            ? Row(
                                children: [
                                  Text(
                                    doneDate,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: ColorSystem.gray5,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    color: ColorSystem.green,
                                  ),
                                ],
                              )
                            : const Icon(
                                Icons.check_circle_outline_rounded,
                                color: ColorSystem.green2,
                              ),
                      ],
                    ),
                  ),
                  ListTile(
                    tileColor: Colors.white,
                    title: Text(
                      wordData.wordCard.word,
                      style: TextStyle(
                        fontSize: widget.type == 2 ? 19 : 24,
                        fontWeight: FontWeight.w600,
                        color: ColorSystem.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      wordData.wordCard.speaker,
                      style: TextStyle(
                        fontSize: widget.type == 2 ? 16 : 20,
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
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.pageController.dispose();
    super.dispose();
  }
}
