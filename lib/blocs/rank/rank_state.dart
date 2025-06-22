import 'package:quiz/data/model/userReyting/user_reyting_model.dart';
import '../auth/auth_state.dart';

class RankState {
  const RankState({
    required this.errorText,
    required this.formStatus,
    required this.statusMessage,
    required this.userRatingModel
  });


  final List<UserRatingModel> userRatingModel;
  final String errorText;
  final String statusMessage;
  final FormStatus formStatus;

  RankState copyWith({
    List<UserRatingModel>? userRatingModel,
    String? errorText,
    FormStatus? formStatus,
    String? statusMessage,
  }) {
    return RankState(
      userRatingModel: userRatingModel ?? this.userRatingModel,
      errorText: errorText ?? this.errorText,
      statusMessage: statusMessage ?? this.statusMessage,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
