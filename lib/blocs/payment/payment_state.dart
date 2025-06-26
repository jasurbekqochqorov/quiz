import 'package:quiz/data/model/userReyting/user_reyting_model.dart';
import '../auth/auth_state.dart';

class PaymentState {
  const PaymentState({
    required this.errorText,
    required this.formStatus,
    required this.statusMessage,
  });


  final String errorText;
  final String statusMessage;
  final FormStatus formStatus;

  PaymentState copyWith({
    String? errorText,
    FormStatus? formStatus,
    String? statusMessage,
  }) {
    return PaymentState(
      errorText: errorText ?? this.errorText,
      statusMessage: statusMessage ?? this.statusMessage,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
