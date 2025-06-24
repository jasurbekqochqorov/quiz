class   QuestionModel{
  final int? id;
  final int number;
  final String image;
  final String text;
  final String a;
  final String b;
  final String c;
  final String d;
  QuestionModel({
    this.id,
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

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json["id"] as int? ?? 0,
      image: json["image"] as String? ?? "",
      text: json["text"] as String? ?? "",
      a: json["a"] as String? ?? "",
      b: json["b"] as String? ?? "",
      c: json["c"] as String? ?? "",
      d: json["d"] as String? ?? "",
      number: json["number"] as int? ?? 0,
    );
  }


  QuestionModel copyWith({
    int? id,
    String? image,
    String? text,
    String? a,
    String? b,
    String? c,
    String? d,
    int? number,
  }) {
    return QuestionModel(
      id: id ?? this.id,
        image: image ?? this.image,
        text: text ?? this.text,
        a: a ?? this.a,
      b: b ?? this.b,
      c: c ?? this.c,
      d: d ?? this.d,
      number: number ?? this.number
    );
  }

  static QuestionModel initial() => QuestionModel(
      image: "",
      text: '',
      a: '',
      b: '',
      c: "",
      d: "",
      number:0
  );
}
