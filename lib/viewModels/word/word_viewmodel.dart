import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earlips/models/user_word_model.dart';
import 'package:earlips/models/word_card_model.dart';
import 'package:earlips/models/word_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WordViewModel extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxList<WordData> wordList = RxList<WordData>([]);
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWords();
    fetchWords();
    wordList.refresh();
  }

  void updateCurrentIndex(int index) {
    currentIndex.value = index;
  }

  // 단어 데이터 가져오기
  Future<void> fetchWords() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      // 모든 단어 데이터 가져오기
      final wordsQuery = await _firestore.collection('words').get();
      final allWords = wordsQuery.docs
          .map((doc) => WordCard.fromDocument(doc.data()))
          .toList();

      // 현재 사용자의 단어 데이터 가져오기
      final userWordsQuery = await _firestore
          .collection('users')
          .doc(uid)
          .collection('words')
          .get();
      final userWords = userWordsQuery.docs
          .map((doc) => UserWord.fromDocument(doc.data()))
          .toList();

      // 모든 단어 데이터에 사용자의 단어 데이터를 추가
      wordList.value = allWords.map((word) {
        final matchingUserWord = userWords
            .firstWhereOrNull((userWord) => userWord.wordId == word.id);

        return WordData(
          wordCard: word,
          userWord: matchingUserWord,
        );
      }).toList();
      update();
    }
  }

  // 단어 완료 처리
  Future<void> markWordAsDone(WordCard word) async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      // Add or update data in the user's 'words' subcollection in Firestore
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('words')
          .doc(word.id.toString())
          .set({
        'wordId': word.id,
        'isDone': true,
        'doneDate': DateFormat('yyyy/MM/dd').format(DateTime.now()),
      });

      final index =
          wordList.indexWhere((element) => element.wordCard.id == word.id);
      if (index != -1) {
        // Handle the scenario where we don't find the card locally.
        wordList[index] = WordData(
          wordCard: word,
          userWord: UserWord(
            wordId: word.id,
            isDone: true,
            doneDate: DateFormat('yyyy/MM/dd').format(DateTime.now()),
          ),
        );
        wordList.refresh();
      }
    }
  }
}
