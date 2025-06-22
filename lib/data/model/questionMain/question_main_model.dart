import 'package:quiz/data/model/Question/question_model.dart';

class QuestionMainModel{
  final String title;
  final List<QuestionModel> questions;
  final int id;
  final int deadline;

  QuestionMainModel({
    required this.id,
    required this.title,
    required this.questions,
    required this.deadline,
  });



  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'questions': questions,
      'deadline': deadline,
    };
  }

  factory QuestionMainModel.fromJson(Map<String, dynamic> json) {
    return QuestionMainModel(
      id: json["id"] as int? ?? 0,
      title: json["title"] as String? ?? "",
      deadline: json["deadline"] as int? ?? 0,
      questions: (json["question"]  as List<dynamic>).map((e)=>QuestionModel.fromJson(e as Map<String, dynamic>)).toList() as List<QuestionModel>? ?? [],
    );
  }


  QuestionMainModel copyWith({
    int? id,
    String? title,
    int? deadline,
    List<QuestionModel>? questions
  }) {
    return QuestionMainModel(
        id: id ?? this.id,
        title: title ?? this.title,
        deadline: deadline ?? this.deadline,
      questions: questions ?? this.questions
      
    );
  }

  static QuestionMainModel initial() => QuestionMainModel(
      title: '',
      deadline: 0,
    questions: [], id: 0
  );
}
