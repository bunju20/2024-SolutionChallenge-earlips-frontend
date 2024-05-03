class WordCard {
  final int id;
  final String word;
  final String speaker;
  final String video;
  final int type;
  final List<int> intensities;
  final List<int> pattern;

  WordCard({
    required this.id,
    required this.word,
    required this.speaker,
    required this.video,
    required this.type,
    required this.intensities,
    required this.pattern,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'speaker': speaker,
      'video': video,
      'type': type,
      'intensities': intensities.join(','),
      'pattern': pattern.join(','),
    };
  }

  factory WordCard.fromDocument(Map<String, dynamic> doc) {
    List<int> parseToIntList(String numbers) {
      return numbers.split(',').map((s) => int.parse(s.trim())).toList();
    }

    return WordCard(
      id: doc['id'],
      word: doc['word'],
      speaker: doc['speaker'],
      video: doc['video'],
      type: doc['type'],
      intensities: doc['intensities'] != null ? parseToIntList(doc['intensities']) : [],
      pattern: doc['pattern'] != null ? parseToIntList(doc['pattern']) : [],

    );
  }

  WordCard copyWith({
    int? id,
    String? word,
    String? speaker,
    String? video,
    int? type,
    List<int>? intensities,
    List<int>? pattern,
  }) {
    return WordCard(
      id: id ?? this.id,
      word: word ?? this.word,
      speaker: speaker ?? this.speaker,
      video: video ?? this.video,
      type: type ?? this.type,
      intensities: intensities ?? this.intensities,
      pattern: pattern ?? this.pattern,
    );
  }
}
