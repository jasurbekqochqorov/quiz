import 'package:flutter/cupertino.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/blocs/test/test_event.dart';
import 'package:quiz/blocs/test/test_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/data/model/resultMain/result_main_model.dart';
import 'package:quiz/data/model/test_model/test_model.dart';
import 'package:quiz/data/repositories/test_repository.dart';
import '../../data/model/coin_model/coin_model.dart';
import '../../data/model/questionMain/question_main_model.dart';

class TestBloc extends Bloc<TestEvent,TestState> {
  TestBloc({required TestRepository testRepository})
      : _testRepository = testRepository,
        super(
          TestState(
            coinModel: CoinModel.initial(),
            questions: QuestionMainModel.initial(),
            errorText: "",
            formStatus:FormStatus.pure,
            testModel:[],
            statusMessage: "",
            userToken: '',
            resultMainModel:ResultMainModel.initial()
          ),
        ) {

    on<TestAllEvent>(_getAllTest);
    on<QuestionAllEvent>(_getAllQuestion);
    on<ResultAllEvent>(_getAllResult);
  }

  final TestRepository _testRepository;

  Future<void> _getAllTest(TestAllEvent event, Emitter<TestState> emit) async {
      emit(state.copyWith(formStatus: FormStatus.loading));
      try {
        final response = await _testRepository.getTest(subjectId:event.subjectId);
        if (response.errorText.isEmpty) {
          emit(state.copyWith(
              testModel: response.data as List<TestModel>,
            statusMessage: "test olindi"
          ));
        } else {
          emit(state.copyWith(
            formStatus: FormStatus.error,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          formStatus: FormStatus.error,
          errorText: "Bilmayman nega unday"
        ));
      }
    }

  Future<void> _getAllQuestion(QuestionAllEvent event, Emitter<TestState> emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      final response = await _testRepository.getQuestion(token: event.token,id: event.id);
      if (response.errorText=='not') {
        emit(state.copyWith(
            questions: response.data as QuestionMainModel,
            formStatus: FormStatus.success,
            statusMessage: "savollar olindi"
        ));
      } else {
        emit(state.copyWith(
          formStatus: FormStatus.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        formStatus: FormStatus.error,
      ));
    }
  }

  Future<void> _getAllResult(ResultAllEvent event, Emitter<TestState> emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      final response = await _testRepository.getResult(token: event.token,id: event.id);
      if (response.errorText=='not') {
        emit(state.copyWith(
            resultMainModel: response.data as ResultMainModel,
            formStatus: FormStatus.success,
            statusMessage: "Natijalar olindi"
        ));
      } else {
        emit(state.copyWith(
          formStatus: FormStatus.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        formStatus: FormStatus.error,
      ));
    }
  }
}
