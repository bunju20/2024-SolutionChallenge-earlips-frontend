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
  final int type;

  RxList<WordData> wordList = RxList<WordData>([]);
  RxInt currentIndex = 0.obs;

  WordViewModel({required this.type});

  @override
  void onInit() {
    super.onInit();
    fetchWords(type);
    wordList.refresh();
  }

  void updateCurrentIndex(int index) {
    currentIndex.value = index;
  }

  // 단어 데이터 가져오기
  Future<void> fetchWords(int type) async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      // 모든 단어 데이터 가져오기
      final wordsQuery = await _firestore
          .collection('words')
          .where('type', isEqualTo: type)
          .get();

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
    String currentDate = DateFormat('yyyy/MM/dd').format(DateTime.now().subtract(Duration(days: 9)));

    if (uid != null) {
      // 유저 단어 데이터 업데이트
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('words')
          .doc(word.id.toString())
          .set({
        'wordId': word.id,
        'isDone': true,
        'doneDate': currentDate,
      });

      // 유저 record 업데이트
      DocumentReference recordRef = _firestore
          .collection('users')
          .doc(uid)
          .collection('records')
          .doc(DateFormat('yyyyMMdd').format(DateTime.now().subtract(Duration(days: 9))));

      try {
        await _firestore.runTransaction((transaction) async {
          // Get the current record
          DocumentSnapshot recordSnapshot = await transaction.get(recordRef);

          if (recordSnapshot.exists) {
            String existingDate = recordSnapshot.get('date');
            if (existingDate == currentDate) {
              transaction.update(recordRef, {
                'cnt': FieldValue.increment(1),
              });
            }
          } else {
            print('different date!!!!!!!!!!!!!');
            transaction.set(recordRef, {
              'cnt': 1,
              'date': currentDate,
              'dateFormat': DateTime.now(),
            });
          }
        });
      } catch (e) {
        print("Transaction failed: $e");
      }
      // 로컬에서 단어 데이터 업데이트
      final index =
          wordList.indexWhere((element) => element.wordCard.id == word.id);

      // 만약 로컬에서 단어를 찾지 못했을 경우를 대비
      if (index != -1) {
        // 단어 데이터 업데이트
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
