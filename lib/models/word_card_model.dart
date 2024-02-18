class WordCard {
  final int id;
  final String word;
  final String speaker;
  final String video;
  final int type;

  WordCard({
    required this.id,
    required this.word,
    required this.speaker,
    required this.video,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'speaker': speaker,
      'video': video,
      'type': type,
    };
  }

  factory WordCard.fromDocument(Map<String, dynamic> doc) {
    return WordCard(
      id: doc['id'],
      word: doc['word'],
      speaker: doc['speaker'],
      video: doc['video'],
      type: doc['type'],
    );
  }

  WordCard copyWith({
    int? id,
    String? word,
    String? speaker,
    String? video,
    int? type,
  }) {
    return WordCard(
      id: id ?? this.id,
      word: word ?? this.word,
      speaker: speaker ?? this.speaker,
      video: video ?? this.video,
      type: type ?? this.type,
    );
  }
}
