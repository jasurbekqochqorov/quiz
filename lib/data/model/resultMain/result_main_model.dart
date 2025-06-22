import 'package:quiz/data/model/result/result_model.dart';

class ResultMainModel {
  final String title;
  final int id;
  final List<ResultModel> question;

  ResultMainModel({
    required this.question,
    required this.id,
    required this.title,
  });

  factory ResultMainModel.fromJson(Map<String, dynamic> json) {
    return ResultMainModel(
      question: (json["question"] as List<dynamic>).map((e)=>ResultModel.fromJson(e as Map<String,dynamic>)).toList() as List<ResultModel>? ?? [],
      title: json["title"] as String? ?? "",
      id: json["id"] as int? ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }

  ResultMainModel copyWith({
    String? title,
    int? id,
    List<ResultModel>? question
  }) {
    return ResultMainModel(
      question: question ?? this.question,
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  static ResultMainModel initial() => ResultMainModel(
      title: "",
    question: [],
    id: 0
  );
}
