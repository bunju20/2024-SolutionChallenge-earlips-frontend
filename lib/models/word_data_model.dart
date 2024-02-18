import 'package:earlips/models/user_word_model.dart';
import 'package:earlips/models/word_card_model.dart';

class WordData {
  final WordCard wordCard;
  final UserWord? userWord;

  WordData({
    required this.wordCard,
    this.userWord,
  });
}
