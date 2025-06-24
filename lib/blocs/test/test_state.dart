import 'package:quiz/data/model/answerResult/aswer_result_model.dart';
import 'package:quiz/data/model/coin_model/coin_model.dart';
import 'package:quiz/data/model/questionMain/question_main_model.dart';
import 'package:quiz/data/model/resultMain/result_main_model.dart';
import 'package:quiz/data/model/test_model/test_model.dart';
import '../auth/auth_state.dart';

class TestState {
  const TestState({
    required this.userToken,
    required this.errorText,
    required this.formStatus,
    required this.testModel,
    required this.statusMessage,
    required this.questions,
    required this.coinModel,
    required this.resultMainModel,
    required this.answer
  });


  final CoinModel coinModel;
  final AnswerResultModel answer;
  final QuestionMainModel questions;
  final String errorText;
  final String statusMessage;
  final List<TestModel> testModel;
  final FormStatus formStatus;
  final String userToken;
  final ResultMainModel resultMainModel;

  TestState copyWith({
    CoinModel? coinModel,
    String? errorText,
    QuestionMainModel? questions,
    FormStatus? formStatus,
    List<TestModel>? testModel,
    String? statusMessage,
    String? userToken,
    ResultMainModel? resultMainModel,
    AnswerResultModel? answer
  }) {
    return TestState(
      answer: answer ?? this.answer,
      resultMainModel:  resultMainModel ?? this.resultMainModel,
      coinModel: coinModel ?? this.coinModel,
      questions: questions ?? this.questions,
      errorText: errorText ?? this.errorText,
      statusMessage: statusMessage ?? this.statusMessage,
      testModel: testModel?? this.testModel,
      formStatus: formStatus ?? this.formStatus,
      userToken: userToken ?? this.userToken,
    );
  }
}
