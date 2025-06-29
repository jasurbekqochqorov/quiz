import 'package:flutter/cupertino.dart';
import 'package:quiz/blocs/auth/auth_state.dart';
import 'package:quiz/blocs/payment/payment_event.dart';
import 'package:quiz/blocs/payment/payment_state.dart';
import 'package:quiz/blocs/rank/rank_event.dart';
import 'package:quiz/blocs/rank/rank_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/data/model/userReyting/user_reyting_model.dart';
import 'package:quiz/data/repositories/test_repository.dart';

class PaymentBloc extends Bloc<PaymentEvent,PaymentState> {
  PaymentBloc({required TestRepository testRepository})
      : _testRepository = testRepository,
        super(
        PaymentState(
            errorText: "",
            formStatus:FormStatus.pure,
            statusMessage: "",
          ),
        ) {

    on<PostPaymentEvent>(_postPayment);
    on<PayPaymentEvent>(_payPayment);
  }

  final TestRepository _testRepository;

  Future<void> _postPayment(PostPaymentEvent event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      final response = await _testRepository.postPayment(summa:event.summa);
      if (response.errorText=="not") {
        debugPrint("SSSSSSSSSS${response.data}");
        emit(state.copyWith(
            formStatus: FormStatus.success,
            statusMessage:"${response.data}"));
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

  Future<void> _payPayment(PayPaymentEvent event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      final response = await _testRepository.payPayment(id:event.id);
      if (response.errorText=="not") {
        debugPrint("SSSSSSSSSS2");
        emit(state.copyWith(
            formStatus: FormStatus.pure,
            statusMessage:"To'landi"));
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
