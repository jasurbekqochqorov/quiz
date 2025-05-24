import 'package:quiz/data/model/login_model/login_model.dart';
import 'package:quiz/data/model/subject/subject_model.dart';
import 'package:quiz/data/model/test_model/test_model.dart';
import 'package:equatable/equatable.dart';

class TestEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TestAllEvent extends TestEvent {
  TestAllEvent({required this.token});

  final String token;

  @override
  List<Object?> get props => [token];
}




