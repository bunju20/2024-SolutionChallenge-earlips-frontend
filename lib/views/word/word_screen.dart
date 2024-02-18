import 'package:earlips/utilities/style/color_styles.dart';
import 'package:earlips/views/word/widget/blue_back_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// word dummy Daaa
final List<WordCard> wordList = [
  WordCard(
      id: 1,
      word: "강",
      speaker: "가-앙",
      isDone: false,
      doneDate: "2021/10/10",
      video: "https://www.youtube.com/watch?v=OzHrIz-wMLA"),
  WordCard(
      id: 2,
      word: "서",
      speaker: "가-앙",
      isDone: false,
      doneDate: "2022/10/10",
      video: "https://www.youtube.com/watch?v=OzHrIz-wMLA"),
  WordCard(
      id: 3,
      word: "희",
      speaker: "가-앙",
      isDone: false,
      video: "https://www.youtube.com/watch?v=OzHrIz-wMLA"),
  WordCard(
      id: 4,
      word: "찬",
      speaker: "차-안",
      isDone: false,
      video: "https://www.youtube.com/watch?v=OzHrIz-wMLA"),
  WordCard(
      id: 5,
      word: "캬",
      speaker: "캬",
      isDone: true,
      doneDate: "2023/10/10",
      video: "https://www.youtube.com/watch?v=OzHrIz-wMLA"),
  // Add more WordCard instances as needed
];

class WordCard {
  final int id;
  final String word;
  final String speaker;
  final bool isDone;
  final String? doneDate;
  final String video;

  WordCard(
      {required this.id,
      required this.word,
      required this.speaker,
      required this.isDone,
      this.doneDate,
      required this.video});
}

class WordScreen extends StatelessWidget {
  final String title;
  final int type;

  const WordScreen({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlueBackAppbar(title: title),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: WordList(wordList: wordList),
                  ),
                  const SizedBox(
                    height: 70,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "아래의 혀, 입술 모양을 따라 말해보세요!",
                          style: TextStyle(
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
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class WordList extends StatefulWidget {
  final List<WordCard> wordList;

  const WordList({super.key, required this.wordList});

  @override
  _WordListState createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.165,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.wordList.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                color: ColorSystem.white,
                border: Border.all(color: const Color(0xffB3CBE2), width: 4),
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
                          '${currentIndex + 1}/${widget.wordList.length}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorSystem.gray5,
                          ),
                        ),

                        // isDone 여부에 따라 다른 체크박스 아이콘을 표시합니다.
                        widget.wordList[index].isDone
                            ? Row(
                                children: [
                                  Text(widget.wordList[index].doneDate!,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: ColorSystem.gray5)),
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
                    title: Text(widget.wordList[index].word,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: ColorSystem.black,
                        ),
                        textAlign: TextAlign.center),
                    subtitle: Text(widget.wordList[index].speaker,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorSystem.gray4,
                        ),
                        textAlign: TextAlign.center),
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
    _pageController.dispose();
    super.dispose();
  }
}
