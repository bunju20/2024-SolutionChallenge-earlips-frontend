class WordCard {
  final int id;
  final String word;
  final String speaker;
  final String video;

  WordCard({
    required this.id,
    required this.word,
    required this.speaker,
    required this.video,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'speaker': speaker,
      'video': video,
    };
  }

  factory WordCard.fromDocument(Map<String, dynamic> doc) {
    return WordCard(
      id: doc['id'],
      word: doc['word'],
      speaker: doc['speaker'],
      video: doc['video'],
    );
  }

  WordCard copyWith({
    int? id,
    String? word,
    String? speaker,
    bool? isDone,
    String? doneDate,
    String? video,
  }) {
    return WordCard(
      id: id ?? this.id,
      word: word ?? this.word,
      speaker: speaker ?? this.speaker,
      video: video ?? this.video,
    );
  }
}
