
class ResultModel{
  final int? id;
  final int number;
  final String image;
  final String text;
  final String a;
  final String b;
  final String c;
  final String d;
  final String answer;
  final String solution;
  final String solutionImage;
  final String userAnswer;
  final int test;
  ResultModel({
    this.id,
    required this.test,
    required this.answer,
    required this.solution,
    required this.solutionImage,
    required this.userAnswer,
    required this.text,
    required this.image,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.number
  });



  Map<String, dynamic> toJson() {
    return {
      "image":image,
      'text': text,
      'a': a,
      'b': b,
      'c': c,
      'd': d,
      "number":number,
    };
  }

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      id: json["id"] as int? ?? 0,
      image: json["image"] as String? ?? "",
      text: json["text"] as String? ?? "",
      a: json["a"] as String? ?? "",
      b: json["b"] as String? ?? "",
      c: json["c"] as String? ?? "",
      d: json["d"] as String? ?? "",
      number: json["number"] as int? ?? 0,
      answer:json["answer"] as String? ?? "",
      userAnswer: json["user_answer"] as String? ?? "",
      test: json["test"] as int? ?? 0,
      solutionImage: json["solution_image"] as String? ?? "",
      solution: json["solution"] as String? ?? ""
    );
  }


  ResultModel copyWith({
    int? id,
    String? image,
    String? text,
    String? a,
    String? b,
    String? c,
    String? d,
    int? number,
    int? test,
    String? solution,
    String? solutionImage,
    String? answer,
    String? userAnswer,
  }) {
    return ResultModel(
        id: id ?? this.id,
        image: image ?? this.image,
        text: text ?? this.text,
        a: a ?? this.a,
        b: b ?? this.b,
        c: c ?? this.c,
        d: d ?? this.d,
        number: number ?? this.number,
        solution: solution ?? this.solution,
        solutionImage: solutionImage ?? this.solutionImage,
        test: test ?? this.test,
        answer: answer ?? this.answer,
        userAnswer:  userAnswer ?? this.userAnswer
    );
  }

  static ResultModel initial() => ResultModel(
      image: "",
      text: '',
      a: '',
      b: '',
      c: "",
      d: "",
      number:0,
    test: 0,
    userAnswer: "",
    answer: "",
    solutionImage: "",
    solution: ""
  );
}
