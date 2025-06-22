class UserTestResultModel{
  UserTestResultModel({
    required this.title,
    required this.price,
    required this.questionCount,
    required this.score,
    required this.testTime,
  });

  final String title;
  final String price;
  final String questionCount;
  final double score;
  final String testTime;



  UserTestResultModel copyWith({
    String? title,
    String? price,
    String? questionCount,
    double? score,
    String? testTime,
  }) =>
      UserTestResultModel(
        title: title ?? this.title,
        price: price ?? this.price,
        questionCount: questionCount ?? this.questionCount,
        score: score ?? this.score,
        testTime: testTime ?? this.testTime,
      );

  factory UserTestResultModel.fromJson(Map<String, dynamic> json) {
    return UserTestResultModel(
      title: json["title"] as String? ?? "",
      price: json["price"] as String? ?? "",
      questionCount: json["questions_count"] as String? ?? "",
      score: json["score"] as double? ?? 0.0,
      testTime: json["test_time"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "price": price,
      "question_count": questionCount,
      "score": score,
      "test_time":testTime,
    };
  }

  static UserTestResultModel initial() => UserTestResultModel(
    title: '',
    price: "",
    questionCount: '',
    score: 0.0,
    testTime: "",
  );
}