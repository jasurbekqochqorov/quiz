import 'package:quiz/data/model/test_model/test_model.dart';

class SubjectModel{
  final String message;
  final List<TestModel> tests;


  SubjectModel({
    required this.message,
    required this.tests
  });



  Map<String, dynamic> toJson() {
    return {
      "message":message,
      "tests":tests
    };
  }

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      message: json["message"] as String? ?? "",
      tests:(json["data"] as List<dynamic>).map((e)=>TestModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }


  SubjectModel copyWith({
    String? message,
    List<TestModel>? tests,
  }) {
    return SubjectModel(
        message: message ?? this.message,
      tests: tests ?? this.tests
    );
  }

  static SubjectModel initial() => SubjectModel(
      message: "",
      tests:[]
  );
}
