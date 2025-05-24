class TestModel{
  final int id;
  final String title;
  final String description;
  final bool isPaid;
  final String price;
  final int questionCount;
  final int duration;


  TestModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.questionCount,
    required this.duration,
    required this.isPaid
  });



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'duration': duration,
      'description': description,
      "is_paid":isPaid,
      "question_count":questionCount,
    };
  }

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json["id"] as int? ?? 0,
      title: json["title"] as String? ?? "",
      price: json["price"] as String? ?? "",
      duration: json["duration"] as int? ?? 0,
      description: json["description"] as String? ?? "",
      questionCount: json["question_count"] as int? ?? 0,
      isPaid: json['is_paid'] as bool? ?? false,
    );
  }


  TestModel copyWith({
    String? title,
    int? id,
    String? price,
    int? questionCount,
    bool? isPaid,
    String? description,
    int? duration,
  }) {
    return TestModel(
      duration: duration ?? this.duration,
      description: description ?? this.description,
      id: id ?? this.id,
      price: price ?? this.price,
      isPaid: isPaid ?? this.isPaid,
      questionCount: questionCount ?? this.questionCount,
      title: title ?? this.title
    );
  }

  static TestModel initial() => TestModel(
    title: '',
    description: '',
    price: '',
    questionCount: 0,
    duration: 0,
    isPaid: false, id: 0
  );
}
