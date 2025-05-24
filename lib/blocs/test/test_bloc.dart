import 'package:flutter/cupertino.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/blocs/test/test_event.dart';
import 'package:quiz/blocs/test/test_state.dart';
import 'package:quiz/data/model/networ_respons_model/network_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/data/repositories/test_repository.dart';
import '../../data/model/subject/subject_model.dart';

class TestBloc extends Bloc<TestEvent,TestState> {
  TestBloc({required TestRepository testRepository})
      : _testRepository = testRepository,
        super(
          TestState(
            errorText: "",
            formStatus:FormStatus.pure,
            subjectModel: SubjectModel.initial(),
            statusMessage: "",
            userToken: '',
          ),
        ) {

    on<TestAllEvent>(_getAllTest);
  }

  final TestRepository _testRepository;

  Future<void> _getAllTest(TestAllEvent event, Emitter<TestState> emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
        debugPrint("Tokent keldi ${event.token}");

    try {
      final response = await _testRepository.getTest(token: event.token);
        debugPrint("XATO:${response.errorText}");
      if (response.errorText=='not') {
        debugPrint("Blockga mau;lmot keldi");
        emit(state.copyWith(
          subjectModel: response.data as SubjectModel,
          formStatus: FormStatus.success,
          statusMessage: "success"
        ));
      } else {
        debugPrint("Blockga mau;lmot kelmadi");
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
