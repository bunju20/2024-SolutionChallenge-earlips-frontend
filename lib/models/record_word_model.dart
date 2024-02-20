class RecordWordModel {
  final String pronunciation;
  final int similarity;

  RecordWordModel({required this.pronunciation, required this.similarity});

  factory RecordWordModel.fromJson(Map<String, dynamic> json) {
    return RecordWordModel(
      pronunciation: json['pronunciation'],
      similarity: json['similarity'],
    );
  }
}
