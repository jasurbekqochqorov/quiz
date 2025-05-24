import 'package:quiz/data/model/subject/subject_model.dart';
import '../auth/auth_state.dart';

class TestState {
  const TestState({
    required this.userToken,
    required this.errorText,
    required this.formStatus,
    required this.subjectModel,
    required this.statusMessage,
  });

  final String errorText;
  final String statusMessage;
  final SubjectModel subjectModel;
  final FormStatus formStatus;
  final String userToken;

  TestState copyWith({
    String? errorText,
    FormStatus? formStatus,
    SubjectModel? subjectModel,
    String? statusMessage,
    String? userToken,
  }) {
    return TestState(
      errorText: errorText ?? this.errorText,
      statusMessage: statusMessage ?? this.statusMessage,
      subjectModel: subjectModel?? this.subjectModel,
      formStatus: formStatus ?? this.formStatus,
      userToken: userToken ?? this.userToken,
    );
  }
}
