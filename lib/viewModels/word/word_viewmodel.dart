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
  // loading
  RxBool isLoading = true.obs;

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
    isLoading.value = true;
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
      isLoading.value = false;
    }
  }

  // 단어 완료 처리
  Future<void> markWordAsDone(WordCard word) async {
    final uid = _auth.currentUser?.uid;
    String currentDate = DateFormat('yyyy/MM/dd').format(DateTime.now());

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
      // daily record 업데이트
      DocumentReference dailyRecordRef = _firestore
          .collection('users')
          .doc(uid)
          .collection('daily_records')
          .doc(DateFormat('yyyyMMdd').format(DateTime.now()));

      try {
        await _firestore.runTransaction((transaction) async {
          // 현재 daily record 가져오기
          DocumentSnapshot recordSnapshot =
              await transaction.get(dailyRecordRef);

          // 만약 단어가 이미 있는지 확인
          if (recordSnapshot.exists) {
            // 기존 단어 리스트 가져오기
            List<Map<String, dynamic>> existingWordsList =
                List<Map<String, dynamic>>.from(
                    recordSnapshot.get('wordsList') ?? []);

            // 이미 있는 단어인지 확인
            if (existingWordsList
                .any((element) => element['word'] == word.word)) {
              // 만약 이미 있는 단어라면 return
              return;
            } else {
              // 만약 없는 단어라면 추가
              existingWordsList.add({
                'word': word.word,
                'type': word.type,
                'index': currentIndex.value
              });

              // 업데이트
              transaction
                  .update(dailyRecordRef, {'wordsList': existingWordsList});
            }
          } else {
            // 만약 daily record가 없다면 새로 생성
            transaction.set(dailyRecordRef, {
              'wordsList': [
                {
                  'word': word.word,
                  'type': word.type,
                  'index': currentIndex.value
                },
              ],
            });
          }
        });
      } catch (_) {}

      // 유저 record 업데이트
      DocumentReference recordRef = _firestore
          .collection('users')
          .doc(uid)
          .collection('records')
          .doc(DateFormat('yyyyMMdd').format(DateTime.now()));
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
