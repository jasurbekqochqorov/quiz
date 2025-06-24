
class AnswerResultModel {
  final int score;
  final int rank;
  final int questionCount;

  AnswerResultModel({
    required this.score,
    required this.rank,
    required this.questionCount,
  });

  factory AnswerResultModel.fromJson(Map<String, dynamic> json) {
    return AnswerResultModel(
      score: json["score"] as int? ?? 0,
      rank: json["rank"] as int? ?? 0,
      questionCount: json["questions_count"] as int? ?? 0,
    );
  }


  static AnswerResultModel initial() => AnswerResultModel(
      score: 0,
      rank: 0,
      questionCount: 0
  );
}
