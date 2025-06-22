import 'package:flutter/cupertino.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/blocs/rank/rank_event.dart';
import 'package:quiz/blocs/rank/rank_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/data/model/userReyting/user_reyting_model.dart';
import 'package:quiz/data/repositories/test_repository.dart';

class RankBloc extends Bloc<RankEvent,RankState> {
  RankBloc({required TestRepository testRepository})
      : _testRepository = testRepository,
        super(
          RankState(
            userRatingModel:[],
            errorText: "",
            formStatus:FormStatus.pure,
            statusMessage: "",
          ),
        ) {

    on<RankEvent>(_getRating);
  }

  final TestRepository _testRepository;

  Future<void> _getRating(RankEvent event, Emitter<RankState> emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      final response = await _testRepository.getRating();
      if (response.errorText=='Rating keldi') {
        emit(state.copyWith(
          userRatingModel:response.data as List<UserRatingModel>,
            formStatus: FormStatus.success,
            statusMessage: "Rating keldi"));
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
