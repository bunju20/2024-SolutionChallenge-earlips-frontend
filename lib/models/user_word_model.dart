class UserWord {
  final int wordId;
  final bool isDone;
  final String? doneDate;

  UserWord({
    required this.wordId,
    required this.isDone,
    this.doneDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'wordId': wordId,
      'isDone': isDone,
      'doneDate': doneDate,
    };
  }

  factory UserWord.fromDocument(Map<String, dynamic> doc) {
    return UserWord(
      wordId: doc['wordId'],
      isDone: doc['isDone'],
      doneDate: doc['doneDate'],
    );
  }
}
