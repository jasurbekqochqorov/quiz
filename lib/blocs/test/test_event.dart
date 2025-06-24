import 'package:equatable/equatable.dart';
import '../../data/model/test_model/test_model.dart';

class TestEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TestAllEvent extends TestEvent {
  TestAllEvent({required this.subjectId});
  final int subjectId;
  @override
  List<Object?> get props => [subjectId];
}


class QuestionAllEvent extends TestEvent {
  QuestionAllEvent({required this.token,required this.id});
  final String token;
  final int id;

  @override
  List<Object?> get props => [token,id];
}

class ResultAllEvent extends TestEvent {
  ResultAllEvent({required this.token,required this.id});
  final String token;
  final int id;

  @override
  List<Object?> get props => [token,id];
}

class PostResultAllEvent extends TestEvent {
  PostResultAllEvent({required this.answers,required this.id});
  final List<Map<String,dynamic>> answers;
  final int id;

  @override
  List<Object?> get props => [answers];
}




